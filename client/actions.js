import { parseCommand } from './util';

export const types = {
  RECEIVE_KEY: 'RECEIVE_KEY',
  SEND_KEY: 'SEND_KEY',
  NEW_MESSAGE: 'NEW_MESSAGE',
  USER_JOINED: 'USER_JOINED',
  USER_LEFT: 'USER_LEFT',
  INVALIDATE_INPUT: 'INVALIDATE_INPUT',
  CHANGE_USERNAME: 'CHANGE_USERNAME'
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

    if (userMessage.content.charAt(0) === '/') {
      const action = parseCommand(userMessage.content);
      if (action) dispatch(action);
    }

    dispatch(newMessage());
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
