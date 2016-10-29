import { types } from './actions';

const defaultState = {
  messages: [],
  input: ''
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