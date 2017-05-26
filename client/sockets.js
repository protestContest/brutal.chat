/* globals io */

import { receiveKey, userJoined, userLeft, beKicked, userKicked, recordStarted, recordStopped } from './actions';

export default {
  init: (store) => {
    const { user } = store.getState();

    window.socket = io();
    window.socket.on('key', (key) => store.dispatch(receiveKey(key)));
    window.socket.on('joined', (user) => store.dispatch(userJoined(user)));
    window.socket.on('left', (user) => store.dispatch(userLeft(user)));
    window.socket.on('kick', () => store.dispatch(beKicked()));
    window.socket.on('kicked', (user) => store.dispatch(userKicked(user)));
    window.socket.on('startRecording', () => store.dispatch(recordStarted()));
    window.socket.on('stopRecording', (ts) => store.dispatch(recordStopped(ts)));

    window.socket.emit('joined', user);
  }
};