const socketIo = require('socket.io');

module.exports = function(server) {
  const io = socketIo(server);

  io.on('connection', (socket) => {
    socket.on('key', (key) => {
      console.log('sending key');
      socket.broadcast.emit('key', key);
    });

    socket.on('joined', (username) => {
      socket.broadcast.emit('joined', username);
    });
  });
};