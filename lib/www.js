var http = require('http'),
    bouncy = require('bouncy'),
    path = require('path'),
    fs = require('fs'),
    nservDir = process.env.HOME + '/.nserv';
    
var config = {};

fs.readFile(nservDir + '/domains.json', function (err, data) {
  if (err) throw err;
  config = JSON.parse(data);
  bouncy(function (req, bounce) {
    var domain = req.headers.host;
    if(typeof config[domain] !== 'undefined'){
      var port = config[domain].port;
      bounce(port, { headers: { Connection: 'close' } });
    }
    else {
      var res = bounce.respond();
      res.statusCode = 404;
      res.write('no such host');
      res.end();
    }
  }).listen(80);
});

fs.watchFile(nservDir + '/domains.json', function (curr, prev) {
  fs.readFile(nservDir + '/domains.json', function (err, data) {
    if (err) throw err;
    config = JSON.parse(data);
  });
});