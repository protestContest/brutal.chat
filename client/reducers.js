import { types } from './actions';
import usernames from './usernames';

const defaultState = {
  messages: [
    /*{
      id: 'asdf',
      content: 'Hello',
      author: 'JohnDoe',
      timestamp: Date.now()
    }*/
  ],
  inputMessage: null,
  user: getUserName(),
  events: [
    {
      id: 'event-1',
      timestamp: Date.now(),
      content: 'Welcome'
    }
  ]
};

export default function(state = defaultState, action) {
  switch(action.type) {
  case types.SEND_KEY:
    return addKey(state, action.payload);

  case types.NEW_MESSAGE:
    const newMessage = createMessage(state.user);

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

  default:
    return state;
  }
}

function getUserName() {
  return usernames[Math.floor(Math.random() * usernames.length)];
}

function addKey(state, key) {
  const message = (state.inputMessage)
    ? { ...state.messages.find(message => message.id === state.inputMessage) }
    : createMessage(state.user);

  if (key === 'Backspace') {
    message.content = message.content.slice(0, -1);
  } else {
    message.content += key;
  }

  return {
    ...state,
    inputMessage: message.id,
    messages: [
      ...state.messages.filter(currentMessage => currentMessage.id !== message.id),
      message
    ]
  };
}

function createMessage(author) {
  return {
    id: author + '-' + (new Date().valueOf()),
    author: author,
    content: '',
    timestamp: Date.now()
  };
}
