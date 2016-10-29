const socketIo = require('socket.io');

module.exports = function(server) {
  const io = socketIo(server);

  io.on('connection', (socket) => {
    socket.broadcast.emit('joined', socket.id);
    socket.on('message', function(message) {
      console.log(message);
      socket.broadcast.send(message);
    });
  });
};