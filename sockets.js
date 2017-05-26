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

    socket.on('kick', (username) => {
      let kickUser = null;
      for (let socketId in io.sockets.sockets) {
        if (io.sockets.sockets[socketId]
            && io.sockets.sockets[socketId].username === username) {
          kickUser = io.sockets.sockets[socketId];
          break;
        }
      }

      if (kickUser) {
        kickUser.emit('kick');
        kickUser.kicked = true;
        kickUser.disconnect(true);
      }
    });

    socket.on('disconnect', () => {
      if (socket.kicked) {
        socket.broadcast.emit('kicked', socket.username);
      } else {
        socket.broadcast.emit('left', socket.username);
      }
    });
  });
};
