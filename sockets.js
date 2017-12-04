const socketIo = require('socket.io');

module.exports = function(server, redis) {
  const io = socketIo(server);
  // let recordId = null;
  let recordIds = {};

  io.on('connection', (socket) => {
    socket.room = 'default';
    socket.join('default');

    socket.changeRoom = (room) => {
      socket.broadcast.to(socket.room).emit('left', socket.username);
      socket.leave(socket.room);

      socket.room = room;
      socket.join(room);
      socket.broadcast.to(room).emit('joined', socket.username);
    };

    socket.on('key', (key) => {
      socket.broadcast.to(socket.room).emit('key', key);

      if (recordIds[socket.room]) {
        redis.rpush(recordIds[socket.room], JSON.stringify(key));
      }
    });

    socket.on('joined', (username) => {
      socket.username = username;
      socket.broadcast.to(socket.room).emit('joined', username);
    });

    socket.on('join', (room) => {
      socket.changeRoom(room);
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

    socket.on('record', () => {
      socket.broadcast.to(socket.room).emit('startRecording');
      socket.emit('startRecording');
      recordIds[socket.room] = `${socket.room}-${Date.now()}`;
    });

    socket.on('stopRecording', () => {
      socket.broadcast.to(socket.room).emit('stopRecording', recordIds[socket.room]);
      socket.emit('stopRecording', recordIds[socket.room]);
      delete recordIds[socket.room];
    });

    socket.on('disconnect', () => {
      if (socket.kicked) {
        socket.broadcast.to(socket.room).emit('kicked', socket.username);
      } else {
        socket.broadcast.to(socket.room).emit('left', socket.username);
      }
    });
  });
};
