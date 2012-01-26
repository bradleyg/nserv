var http = require('http');
var bouncy = require('bouncy');
var path = require('path');
var fs = require('fs');
var nservDir = process.env.HOME + '/.nserv';
    
var config = {};
var nservPort = '8080';

fs.readFile(nservDir + '/domains.json', function (err, data) {
  if (err) throw err;
  config = JSON.parse(data);
  bouncy(function (req, bounce) {
    var domain = req.headers.host.replace(':' + nservPort, '');
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
  }).listen(nservPort);
});

fs.watchFile(nservDir + '/domains.json', function (curr, prev) {
  if(prev.mtime.toString() !== curr.mtime.toString()){
    fs.readFile(nservDir + '/domains.json', function (err, data) {
      if (err) throw err;
      config = JSON.parse(data);
    });
  }
});