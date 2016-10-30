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