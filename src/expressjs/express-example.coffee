# Example from the expressjs home page
express = require('express')

app = express.createServer()

app.get('/', (req, res) ->
    console.log('Received a request')
    res.send('Hello World')
)

app.listen(3000)
