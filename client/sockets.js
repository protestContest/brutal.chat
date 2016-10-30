/* globals io */

import { receiveMessage, userJoined } from './actions';

export default {
  init: (store) => {
    const { user } = store.getState();
    window.socket = io();
    window.socket.on('message', () => store.dispatch(receiveMessage()));
    window.socket.on('joined', (user) => store.dispatch(userJoined(user)));

    window.socket.emit('joined', user);
  }
};