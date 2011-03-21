express = require('express')
redis   = require('redis-node')
spawn   = require('child_process').spawn

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

        # Spawn the pygmentize process. Make sure it's in the path.
        # I don't do error checking yet.
        # Alternatively I should use the pymentize appspot service.
        pygmentize = spawn('pygmentize', ['-f', 'html', '-l', r.lang])

        pygmentize.stdout.on('data', (data) ->
            console.log("Got Output From Pygmentize")

            # Now syntax highlighting with pygments
            res.render('paste', { layout: false, paste: r, pygment_output: data.toString('utf8') })
        )

        pygmentize.stdin.write(r.code)
        pygmentize.stdin.end()
    )
)

console.log("Start Server")
app.listen(3000)
