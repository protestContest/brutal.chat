export function createMessage(id, author) {
  return {
    id: id || author + '-' + (new Date().valueOf()),
    author: author,
    content: '',
    timestamp: Date.now()
  };
}
