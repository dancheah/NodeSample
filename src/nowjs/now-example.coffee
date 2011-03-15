fs = require('fs')
http = require('http')

server = http.createServer((req, res) ->
    fs.readFile('now-example.html', (err, data) ->
        res.writeHead(200, { 'Content-Type': 'text/html' })
        res.write(data)
        res.end()
    )
)

server.listen(8080)
everyone = require('now').initialize(server)
everyone.now.msg = "Hello World!"
