/* globals io */

import { receiveKey, userJoined, userLeft, beKicked, userKicked, recordStarted, recordStopped } from './actions';

export default {
  init: (dispatch, getState) => {
    const { user } = getState();

    window.socket = io();
    window.socket.on('key', (key) => dispatch(receiveKey(key)));
    window.socket.on('joined', (user) => dispatch(userJoined(user)));
    window.socket.on('left', (user) => dispatch(userLeft(user)));
    window.socket.on('kick', () => dispatch(beKicked()));
    window.socket.on('kicked', (user) => dispatch(userKicked(user)));
    window.socket.on('startRecording', () => dispatch(recordStarted()));
    window.socket.on('stopRecording', (ts) => dispatch(recordStopped(ts)));

    window.socket.emit('joined', user);
  }
};