import { parseCommand } from './util';

export const types = {
  RECEIVE_KEY: 'RECEIVE_KEY',
  SEND_KEY: 'SEND_KEY',
  NEW_MESSAGE: 'NEW_MESSAGE',
  USER_JOINED: 'USER_JOINED',
  USER_LEFT: 'USER_LEFT',
  INVALIDATE_INPUT: 'INVALIDATE_INPUT',
  CHANGE_USERNAME: 'CHANGE_USERNAME',
  KICK: 'KICK',
  BE_KICKED: 'BE_KICKED',
  USER_KICKED: 'USER_KICKED',
  START_RECORD: 'START_RECORD',
  RECORD_STARTED: 'RECORD_STARTED',
  STOP_RECORD: 'STOP_RECORD',
  RECORD_STOPPED: 'RECORD_STOPPED'
};

export function receiveKey(keyInfo) {
  return {
    type: types.RECEIVE_KEY,
    payload: keyInfo
  };
}

export function sendKey(key) {
  return (dispatch, getState) => {
    let { user, inputMessage } = getState();

    if (!inputMessage) {
      dispatch(newMessage());
      const state = getState();
      inputMessage = state.inputMessage;
    }

    window.socket.emit('key', { messageId: inputMessage, key, author: user });
    return dispatch({ type: types.SEND_KEY, payload: { messageId: inputMessage, key, author: user } });
  };
}

export function newMessage() {
  return { type: types.NEW_MESSAGE };
}

export function endMessage() {
  return (dispatch, getState) => {
    const { inputMessage, messages } = getState();

    const userMessage = messages.find(message => message.id === inputMessage);

    if (userMessage && userMessage.content.charAt(0) === '/') {
      const action = parseCommand(userMessage.content);
      if (action) dispatch(action);
    }

    dispatch(invalidateInput());
  };
}

export function userJoined(username) {
  return { type: types.USER_JOINED, payload: username };
}

export function userLeft(username) {
  return { type: types.USER_LEFT, payload: username };
}

export function invalidateInput() {
  return { type: types.INVALIDATE_INPUT };
}

export function changeUsername(username) {
  return { type: types.CHANGE_USERNAME, payload: username };
}

export function kick(username) {
  return () => {
    window.socket.emit('kick', username);
  };
}

export function beKicked() {
  return { type: types.BE_KICKED };
}

export function userKicked(username) {
  return { type: types.USER_KICKED, payload: username };
}

export function startRecord() {
  return () => {
    window.socket.emit('record');
  };
}

export function recordStarted() {
  return { type: types.RECORD_STARTED };
}

export function stopRecord() {
  return () => {
    window.socket.emit('stopRecording');
  };
}

export function recordStopped(timestamp) {
  return { type: types.RECORD_STOPPED, payload: timestamp };
}
