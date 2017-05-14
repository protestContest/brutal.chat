const socketIo = require('socket.io');

module.exports = function(server) {
  const io = socketIo(server);

  io.on('connection', (socket) => {
    socket.on('key', (key) => {
      socket.broadcast.emit('key', key);
    });

    socket.on('joined', (username) => {
      socket.username = username;
      socket.broadcast.emit('joined', username);
    });

    socket.on('disconnect', () => {
      socket.broadcast.emit('left', socket.username);
    });
  });
};