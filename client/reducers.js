import { types } from './actions';
import usernames from './usernames';

const defaultState = {
  messages: [
    {
      id: 'asdf',
      content: 'Hello',
      author: 'JohnDoe'
    }
  ],
  inputMessage: null,
  user: getUserName()
};

export default function(state = defaultState, action) {
  switch(action.type) {
  case types.SEND_KEY:
    return addKey(state, action);

  case types.NEW_MESSAGE:
    return {
      ...state,
      inputMessage: null
    };

  default:
    return state;
  }
}

function getUserName() {
  return usernames[Math.floor(Math.random() * usernames.length)];
}

function addKey(state, action) {
  const message = (state.inputMessage)
    ? { ...state.messages.find(message => message.id === state.inputMessage) }
    : createMessage(state.user);

  if (action.payload === 'Backspace') {
    message.content = message.content.slice(0, -1);
  } else {
    message.content += action.payload;
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