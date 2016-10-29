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
  input: '',
  user: getUserName()
};

export default function(state = defaultState, action) {
  switch(action.type) {
  case types.SEND_KEY:
    if (action.payload === 'Backspace') {
      return {
        ...state,
        input: state.input.slice(0, -1)
      };
    } else {
      return {
        ...state,
        input: state.input + action.payload
      };
    }

  default:
    return state;
  }
}

function getUserName() {
  return usernames[Math.floor(Math.random() * usernames.length)];
}