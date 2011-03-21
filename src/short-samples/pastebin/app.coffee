express = require('express')
redis   = require('redis-node')

# Connect to redis
client  = redis.createClient()
client.select(0)

app = express.createServer()
app.use(express.errorHandler({ dump: true, stack: true }))
app.use(express.bodyParser())
app.use(express.static(__dirname + '/public'))
app.set('views', __dirname + '/views')
app.set('view engine', 'jade')

app.get('/', (req, res) ->
    console.log("Index Request")
    res.render('index', { layout: false })
)

app.post('/paste', (req, res) ->
    console.log("Paste Request")
    # Get a new id for this paste
    client.incr("paste_id", (err, newid) ->
        console.log("New Id #{newid}")
        # I'm assuming that hmset is atomic
        client.hmset("paste-#{newid}", req.body.paste, (e, r) ->
            if (e) 
                throw e
            res.redirect("/paste/#{newid}")
        )
    )
)

# Get something that we pasted
app.get('/paste/:id', (req, res) ->
    console.log("Get Paste Request #{req.params.id}")
    client.hgetall("paste-#{req.params.id}", (e, r) ->
        if (e)
            throw e
        console.log("name: #{r.name}")
        console.log("lang: #{r.lang}")
        console.log("code: #{r.code}")
        res.render('paste', { layout: false, paste: r })
    )
)

console.log("Start Server")
app.listen(3000)
