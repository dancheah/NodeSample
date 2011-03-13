net = require('net')
server = net.createServer((socket) ->
    socket.write("Echo server\r\n")
    socket.pipe(socket)
)

server.listen(8124, "127.0.0.1")
