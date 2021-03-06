/* globals io */

import * as actions from './actions';

export default {
  init: (dispatch, getState) => {
    const { user, room } = getState();

    console.log(user);
    console.log(room);

    window.socket = io();
    window.socket.on('key', (key) => dispatch(actions.receiveKey(key)));
    window.socket.on('joined', (user) => dispatch(actions.userJoined(user)));
    window.socket.on('left', (user) => dispatch(actions.userLeft(user)));
    window.socket.on('kick', () => dispatch(actions.beKicked()));
    window.socket.on('kicked', (user) => dispatch(actions.userKicked(user)));
    window.socket.on('startRecording', () => dispatch(actions.recordStarted()));
    window.socket.on('stopRecording', (ts) => dispatch(actions.recordStopped(ts)));
    window.socket.on('numUsers', numUsers => dispatch(actions.setNumUsers(numUsers)));
    window.socket.on('nick', nicks => dispatch(actions.usernameChanged(nicks.oldNick, nicks.newNick)));
    window.socket.on('users', users => dispatch(actions.setUsers(users)));
    window.socket.on('roomlist', rooms => dispatch(actions.showRooms(rooms)));

    window.socket.emit('joined', { username: user, room });
  }
};