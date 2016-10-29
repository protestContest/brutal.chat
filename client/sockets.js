/* globals io */

import { receiveMessage, userJoined } from './actions';

export default {
  init: () => {
    window.socket = io();
    window.socket.on('message', receiveMessage);
    window.socket.on('joined', userJoined);
  }
};