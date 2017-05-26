import { getUserName } from './util';

export function getDefaultState(recordItems, recordStart) {
  const username = getUserName();

  const initialEvent = (recordItems)
    ? {
      id: 'event-1',
      timestamp: recordStart,
      content: `Recording #${recordStart}`
    }
    : {
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
    events: [ initialEvent ],
    recordStart: recordStart || null,
    recordItems: recordItems || null
  };
}