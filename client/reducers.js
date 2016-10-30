import { types } from './actions';
import usernames from './usernames';

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

  default:
    return state;
  }
}

function getUserName() {
  const adjective = usernames.adjectives[Math.floor(Math.random() * usernames.adjectives.length)];
  const animal = usernames.animals[Math.floor(Math.random() * usernames.animals.length)];

  return adjective + animal;
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

function createMessage(id, author) {
  return {
    id: id || author + '-' + (new Date().valueOf()),
    author: author,
    content: '',
    timestamp: Date.now()
  };
}
