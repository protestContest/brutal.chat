import { getUserName } from './util';

export function getDefaultState(room) {
  const username = getUserName();

  const initialEvent = {
    id: 'event-1',
    timestamp: Date.now(),
    content: `Welcome ${username}`
  };

  return {
    messages: [
      /*{
        id: 'asdf',
        content: 'Hello',
        author: 'quietly',
        timestamp: Date.now()
      }*/
    ],
    inputMessage: null,
    user: username,
    numUsers: 1,
    events: [ initialEvent ],
    recordStart: null,
    recordItems: null,
    appState: 'normal',
    welcome: room === 'default',
    room: room || 'default'
  };
}