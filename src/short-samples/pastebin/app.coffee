express = require('express')
redis   = require('redis-node')

# Connect to redis
client  = redis.createClient()
client.select(0)

app = express.createServer()
app.use(express.errorHandler({ dump: true, stack: true }))
app.use(express.bodyParser())
app.set('views', __dirname + '/views')
app.set('view engine', 'jade')

app.get('/', (req, res) ->
    console.log("Index Request")
    res.render('index', { layout: false })
)

app.post('/paste', (req, res) ->
    console.log("Paste Request")
    console.log("name = #{req.body.post.name}")
    console.log("code = #{req.body.post.code}")

    client.incr("paste_id", (err, newid) ->
        console.log("New Id #{newid}")
        client.transaction(() ->
            client.set("name-#{newid}", req.body.post.name, (e, r) ->
                if (e) 
                    throw e
            )
            client.set("code-#{newid}", req.body.post.code, (e, r) ->
                if (e) 
                    throw e
                res.redirect('/')
            )
        )
    )
)


console.log("Start Server")
app.listen(3000)
