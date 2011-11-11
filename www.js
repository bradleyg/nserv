var http = require('http'),
    httpProxy = require('http-proxy');
    fs = require('fs');
    
var configs = __dirname + '/config/';
    
var config = {};
    
fs.readFile(configs + 'domains.json', function (err, data) {
  if (err) throw err;
  config = JSON.parse(data);
  httpProxy.createServer(function (req, res, proxy) { 
    var domain = req.headers.host;
    if(typeof config[domain] !== 'undefined'){
      var port = config[domain].port;
      options = {
        host: '127.0.0.1',
        port: port
      }
      proxy.proxyRequest(req, res, options);
    }
    else {
      res.setHeader("Content-Type", "text/html");
      res.statusCode = 404;
      res.end("404, no domain here");
    }
  }).listen(80);
});

fs.watchFile(configs + 'domains.json', function (curr, prev) {
  setTimeout(function(){
    fs.readFile(configs + 'domains.json', function (err, data) {
      if (err) throw err;
      config = JSON.parse(data);
    });   
  }, 1 * 1000);
});