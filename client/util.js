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
  const storedUsername = window.sessionStorage.getItem('user');

  if (storedUsername) {
    return storedUsername;
  } else {
    const adjective = usernames.adjectives[Math.floor(Math.random() * usernames.adjectives.length)];
    const animal = usernames.animals[Math.floor(Math.random() * usernames.animals.length)];

    window.sessionStorage.setItem('user', adjective + animal);

    return adjective + animal;
  }
}