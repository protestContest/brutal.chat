const express = require('express');
const router = express.Router();
const redis = require('redis').createClient(process.env.REDIS_URL);

router.get('/', function(req, res) {
  res.render('index');
});

router.get('/replay/:timestamp', function(req, res) {
  redis.lrange(req.params.timestamp, 0, -1, function(err, items) {
    if (err || items.length === 0) {
      res.status(404).send('Not found');
    } else {
      res.send(items);
    }
  });
});

module.exports = router;
