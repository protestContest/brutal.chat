const express = require('express');
const router = express.Router();
const redis = require('redis').createClient(process.env.REDIS_URL);

router.get('/', function(req, res) {
  res.render('index');
});

router.get('/chat/:recordId', function(req, res) {
  redis.lrange(req.params.recordId, 0, -1, function(err, items) {
    if (err || items.length === 0) {
      res.status(404).send('Not found');
    } else {
      const messages = parseItems(items);
      const room = req.params.recordId.split('-')[0];
      const timestamp = req.params.recordId.split('-')[1];
      const d = new Date(parseInt(timestamp));
      const dateStr = `${d.getDate()}-${d.getMonth()}-${d.getFullYear()}`;
      res.render('replay', { messages, title: `${room} ${dateStr} | Brutal` });
    }
  });
});

function parseItems(items) {
  return items.reduce((messages, itemStr) => {
    const item = JSON.parse(itemStr);
    const messageIndex = messages.findIndex(m => m.id === item.messageId);
    if (messageIndex === -1) {
      const ts = parseInt(item.messageId.split('-')[1]);
      const d = new Date(ts);
      const date = `${d.getHours()}:${d.getMinutes()}:${d.getSeconds()} ${d.getDate()}-${d.getMonth()}-${d.getFullYear()}`;

      return [
        ...messages,
        {
          id: item.messageId,
          author: item.author,
          text: item.key,
          ts: ts,
          date: date
        }
      ];
    } else {
      const message = messages[messageIndex];
      message.text += item.key;
      return [
        ...messages.slice(0, messageIndex),
        message,
        ...messages.slice(messageIndex + 1)
      ];
    }
  }, []).sort((m1, m2) => m1.ts - m2.ts);
}

module.exports = router;
