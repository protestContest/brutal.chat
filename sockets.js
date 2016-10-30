const socketIo = require('socket.io');

module.exports = function(server) {
  const io = socketIo(server);

  io.on('connection', (socket) => {
    socket.on('message', (message) => {
      socket.broadcast.send(message);
    });

    socket.on('joined', (username) => {
      console.log(username + ' joined');
      socket.broadcast.emit('joined', username);
    });
  });
};