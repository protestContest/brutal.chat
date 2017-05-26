import usernames from '../usernames';
import { changeUsername, kick, startRecord, stopRecord } from './actions';

export function createMessage(id, author) {
  return {
    id: id || author + '-' + (new Date().valueOf()),
    author: author,
    content: '',
    timestamp: Date.now()
  };
}

export function getUserName() {
  const storedUsername = window.sessionStorage.getItem('user');

  if (storedUsername) {
    return storedUsername;
  } else {
    const username = createUsername();
    window.sessionStorage.setItem('user', username);

    return username;
  }
}

export function createUsername() {
  const adjective = usernames.adjectives[Math.floor(Math.random() * usernames.adjectives.length)];
  const animal = usernames.animals[Math.floor(Math.random() * usernames.animals.length)];
  return adjective + animal;
}

export function parseCommand(input) {
  const match = input.match(/^\/(\w+) ?(.*)$/);

  let command, param = '';
  if (match && match.length > 1) {
    command = match[1];
    param = match[2].trim();
  }

  switch (command) {
  case 'nick':
    return changeUsername(createUsername());

  case 'kick':
    return kick(param);

  case 'jackin':
    window.location = 'http://www.zjm.me';
    break;

  case 'record':
    return startRecord();

  case 'stop':
    return stopRecord();

  default:
    return null;
  }
}
