export const types = {
  SOCKET_MESSAGE: 'SOCKET_MESSAGE',
  SEND_KEY: 'SEND_KEY',
  NEW_MESSAGE: 'NEW_MESSAGE'
};

export function receiveMessage(message) {
  return {
    type: types.SOCKET_MESSAGE,
    payload: message
  };
}

export function sendKey(key) {
  window.socket.send(key);
  return { type: types.SEND_KEY, payload: key };
}

export function newMessage() {
  return { type: types.NEW_MESSAGE };
}