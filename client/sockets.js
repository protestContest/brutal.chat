/* globals io */

import { receiveKey, userJoined } from './actions';

export default {
  init: (store) => {
    const { user } = store.getState();
    window.socket = io();
    window.socket.on('key', (key) => store.dispatch(receiveKey(key)));
    window.socket.on('joined', (user) => store.dispatch(userJoined(user)));

    window.socket.emit('joined', user);
  }
};