import usernames from './usernames';

export function createMessage(id, author) {
  return {
    id: id || author + '-' + (new Date().valueOf()),
    author: author,
    content: '',
    timestamp: Date.now()
  };
}

export function getUserName() {
  const adjective = usernames.adjectives[Math.floor(Math.random() * usernames.adjectives.length)];
  const animal = usernames.animals[Math.floor(Math.random() * usernames.animals.length)];

  return adjective + animal;
}