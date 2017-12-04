const socketIo = require('socket.io');

module.exports = function(server, redis) {
  const io = socketIo(server);
  let recordIds = {};

  io.on('connection', (socket) => {
    socket.changeRoom = (room) => {
      const oldRoom = socket.room;
      socket.broadcast.to(oldRoom).emit('left', socket.username);
      socket.leave(oldRoom);
      redis.srem(oldRoom, socket.username);
      redis.hincrby('numUsers', oldRoom, -1, (err, numUsers) => {
        socket.emit('numUsers', numUsers)
        socket.broadcast.to(oldRoom).emit('numUsers', numUsers)
      });

      socket.room = room;
      socket.join(room);
      socket.broadcast.to(room).emit('joined', socket.username);
      redis.hincrby('numUsers', room, 1, (err, numUsers) => {
        socket.emit('numUsers', numUsers)
        socket.broadcast.to(room).emit('numUsers', numUsers)
      });
      redis.sadd(room, socket.username);
      redis.smembers(room, (err, members) => {
        socket.emit('users', members);
      });
    };

    socket.on('key', (key) => {
      socket.broadcast.to(socket.room).emit('key', key);

      if (recordIds[socket.room]) {
        redis.rpush(recordIds[socket.room], JSON.stringify(key));
      }
    });

    socket.on('joined', ({ username, room }) => {
      socket.room = room || 'default';
      socket.username = username;
      socket.join(socket.room);
      socket.broadcast.to(socket.room).emit('joined', username);

      redis.hincrby('numUsers', socket.room, 1, (err, numUsers) => {
        socket.broadcast.to(socket.room).emit('numUsers', numUsers);
        socket.emit('numUsers', numUsers);
      });
      redis.sadd(socket.room, username);
      redis.smembers(socket.room, (err, members) => {
        socket.emit('users', members);
      });
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

    socket.on('nick', (nicks) => {
      socket.broadcast.to(socket.room).emit('nick', nicks);
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
      const oldRoom = socket.room;
      redis.hincrby('numUsers', oldRoom, -1, (err, numUsers) => {
        redis.srem(oldRoom, socket.username);
        if (socket.kicked) {
          socket.broadcast.to(oldRoom).emit('kicked', socket.username);
        } else {
          socket.broadcast.to(oldRoom).emit('left', socket.username);
        }

        socket.emit('numUsers', numUsers)
        socket.broadcast.to(oldRoom).emit('numUsers', numUsers)
      });
    });
  });
};
