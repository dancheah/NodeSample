###
Trying out the chat room example for now js. Could not get it to
work when I first tried it but started working after nowjs 0.2.3
###
fs = require('fs')
http = require('http')

server = http.createServer((req, res) ->
    fs.readFile('helloworld.html', (err, data) ->
        res.writeHead(200, { 'Content-Type': 'text/html' })
        res.write(data)
        res.end()
    )
)

server.listen(8080)
everyone = require('now').initialize(server)

everyone.connected(() ->
  console.log("Joined: " + this.now.name)
)

everyone.disconnected(() ->
  console.log("Left: " + this.now.name)
)

everyone.now.distributeMessage = (message) -> 
    everyone.now.receiveMessage(this.now.name, message)
