import { types } from './actions';
import { createMessage, getUserName } from './util';

const username = getUserName();

const defaultState = {
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
  events: [
    {
      id: 'event-1',
      timestamp: Date.now(),
      content: `Welcome ${username}`
    }
  ]
};

export default function(state = defaultState, action) {
  switch(action.type) {
  case types.SEND_KEY:
    const messages = addKey(state.messages, action.payload);
    const inputMessage = messages[messages.length - 1].id;

    return {
      ...state,
      messages,
      inputMessage
    };

  case types.RECEIVE_KEY:
    return {
      ...state,
      messages: addKey(state.messages, action.payload)
    };

  case types.NEW_MESSAGE:
    if (inputIsBlank(state.inputMessage, state.messages)) return state;

    const newMessage = createMessage(null, state.user);

    return {
      ...state,
      inputMessage: newMessage.id,
      messages: [
        ...state.messages,
        newMessage
      ]
    };

  case types.USER_JOINED:
    return {
      ...state,
      events: [
        ...state.events,
        {
          id: `joined-${Date.now()}`,
          timestamp: Date.now(),
          content: `${action.payload} joined`
        }
      ]
    };

  case types.USER_LEFT:
    return {
      ...state,
      events: [
        ...state.events,
        {
          id: `left-${Date.now()}`,
          timestamp: Date.now(),
          content: `${action.payload} left`
        }
      ]
    };

  case types.INVALIDATE_INPUT:
    return {
      ...state,
      messages: [
        ...state.messages.filter(message => message.content.length > 0)
      ],
      inputMessage: null
    };

  default:
    return state;
  }
}

function addKey(messages, { messageId, key, author }) {
  const foundMessage = messages.find(message => message.id === messageId);
  let message = (foundMessage)
    ? {...foundMessage}
    : createMessage(messageId, author);

  if (key === 'Backspace') {
    message.content = message.content.slice(0, -1);
  } else {
    message.content += key;
  }

  return [
    ...messages.filter(currentMessage => currentMessage.id !== message.id),
    message
  ];
}

function inputIsBlank(messageId, messages) {
  if (!messageId) return false;
  const foundMessage = messages.find(message => message.id === messageId);
  if (!foundMessage) return false;
  if (foundMessage.content.length > 0) return false;

  return true;
}