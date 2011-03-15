# Simple front end to play around with redis
# and node. Only does GET and SET keys.

express = require('express')
redis   = require('redis-node')

# Connect to redis
client  = redis.createClient()
client.select(0)

# Create http server
app = express.createServer()

# Need this to get access to the body of POST
app.use(express.bodyParser())

# GET route
app.get('/key/:id', (req,res) ->
    console.log("Id = " + req.params.id)
    client.get(req.params.id, (err, data) -> 
        console.log("Data = " + data)
        res.send(data)
    )
)

# SET route
app.post('/key/:id', (req, res) ->
    console.log("Id = " + req.params.id)
    client.set(req.params.id, req.rawBody, (err, data) -> 
        console.log("Wrote = " + req.rawBody)
        res.statusCode = 200

        # This ends the request. Need to do this
        # otherwise the client is left hanging 
        res.end()
    )
)

app.listen(3000)
