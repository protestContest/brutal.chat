import { types } from './actions';
import { createMessage } from './util';

export default function(state, action) {
  switch(action.type) {
  case types.SEND_KEY:
    const messages = addKey(state.messages, action.payload, state.appState);
    const inputMessage = messages[messages.length - 1].id;

    return {
      ...state,
      messages,
      inputMessage
    };

  case types.RECEIVE_KEY:
    return {
      ...state,
      messages: addKey(state.messages, action.payload, state.appState)
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

  case types.CHANGE_USERNAME:
    return {
      ...state,
      user: action.payload,
      events: [
        ...state.events,
        {
          id: `nick-${Date.now()}`,
          timestamp: Date.now(),
          content: `${state.user} is now ${action.payload}`
        }
      ]
    };

  case types.USER_KICKED:
    return {
      ...state,
      events: [
        ...state.events,
        {
          id: `kicked-${Date.now()}`,
          timestamp: Date.now(),
          content: `${action.payload} kicked`
        }
      ]
    };

  case types.BE_KICKED:
    return {
      ...state,
      events: [
        ...state.events,
        {
          id: `kick-${Date.now()}`,
          timestamp: Date.now(),
          content: 'You were kicked'
        }
      ]
    };

  case types.RECORD_STARTED:
    return {
      ...state,
      recordStart: Date.now(),
      appState: 'recording',
      events: [
        ...state.events,
        {
          id: `record-${Date.now()}`,
          timestamp: Date.now(),
          content: 'Recording started'
        }
      ]
    };

  case types.RECORD_STOPPED:
    return {
      ...state,
      recordStart: null,
      appState: 'normal',
      events: [
        ...state.events,
        {
          id: `recordend-${Date.now()}`,
          timestamp: Date.now(),
          content: `Recording finished: <a target='_blank' href='/chat/${action.payload}'>${action.payload}</a>`
        }
      ]
    };

  case types.SET_ROOM:
    return {
      ...state,
      room: action.payload
    };

  case types.ENTER:
    return {
      ...state,
      welcome: false
    };

  default:
    return state;
  }
}

function addKey(messages, { messageId, key, author }, appState) {
  const foundMessage = messages.find(message => message.id === messageId);
  let message = (foundMessage)
    ? {...foundMessage}
    : createMessage(messageId, author);

  if (key === 'Backspace') {
    message.content = message.content.slice(0, -1);
  } else {
    message.content += key;
  }

  if (appState === 'recording') {
    message.recorded = true;
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