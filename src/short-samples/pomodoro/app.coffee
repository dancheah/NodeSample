# Module dependencies.
express = require('express')
redis = require('redis-node')
app = module.exports = express.createServer()
underscore = require('underscore')

client = redis.createClient()
client.select(1)

pubDir = __dirname + '/public'
# Configuration
app.configure(() -> 
    app.set('views', __dirname + '/views')
    app.set('view engine', 'jade')
    app.use(express.bodyParser())
    app.use(express.methodOverride())
    app.use(app.router)
    app.use(express.static(pubDir))
    # Not using sass. Actually using compass
    # app.use(express.compiler({ src: pubDir, enable: ['sass'] })) 
)

app.configure('development', () -> 
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true })) 
)

app.configure('production', () -> 
    app.use(express.errorHandler()) 
)

# Routes
app.get('/', (req, res) -> 
    get_todo_list("todos", (err, result) ->
        if (err)
            throw err

        res.render('index', { title: 'Pomotodo', todo_list: result })
    )
)

app.post('/todo', (req, res) ->
    new_todo_item(req.body.todo, (err, newid) ->
        if (err)
            throw err

        res.redirect("/")
    )
)

new_todo_item = (todo, callback) ->
    client.incr("todo_id", (err, newid) ->
        console.log("New Id #{newid}")
        d = new Date
        k = "todo-#{newid}"
        client.transaction(() ->
            client.hmset(k, todo, (err, r) ->
                if (err)
                    return callback(err, null)

                client.zadd("todos", d.getTime(), k, (err, r) ->
                    return callback(null, newid)
                )
            )
        )
    )

get_todo_list = (todoListKey, callback) ->
    client.zrange(todoListKey, 0, -1, (err, rangeResults) ->
        results = []
        client.transaction(() ->
            for key in rangeResults
                client.hgetall(key, (err, hgetallResults) ->
                    if (err)
                        return callback(err, null)
                    
                    # TODO: Not sure if things back in order. Let's
                    # investigate it later.
                    results.push(hgetallResults)

                    if results.length == rangeResults.length
                        
                        return callback(null, underscore.zip(rangeResults, results))
                )
        )
    )

app.get('/todo', (req, res) ->
    get_todo_list("todos", (err, result) ->
        if (err)
            throw e

        console.log("Send result")
        res.contentType("application/json")
        res.send(result)
    )
)

# Only listen on $ node app.js
if (!module.parent)
    app.listen(3000)
    console.log("Express server listening on port %d", app.address().port)

# vim: sts=4 sw=4 ts=4 et 
