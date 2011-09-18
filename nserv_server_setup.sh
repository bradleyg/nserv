#!/bin/bash

export LANG=en_GB
export LC_ALL=C
locale-gen $LANG
echo LANG=$LANG >> /etc/environment
echo LC_ALL=$LC_ALL >> /etc/environment

apt-get -y update
apt-get -y upgrade
apt-get -y install build-essential
apt-get -y install git-core
apt-get -y install python-software-properties
add-apt-repository ppa:chris-lea/node.js
apt-get -y update
apt-get -y install nodejs
apt-get -y install nodejs-dev

curl http://npmjs.org/install.sh | sh

npm install forever -g

mkdir ~/server
mkdir ~/www

cd ~/server
npm install http-proxy

cat > ~/server/www.js << EOF
var http = require('http'),
    httpProxy = require('http-proxy');

var options = {
	hostnameOnly: true,
	router: {                                                                                  
	}
}
var proxyServer = httpProxy.createServer(options).listen(80);
EOF

forever start ~/server/www.js

curl https://raw.github.com/bradleyg/nserv/master/nserv_deploy.sh > nserv_deploy.sh
chmod +x nserv_deploy.sh
mv nserv_deploy.sh /usr/local/bin/nserv_deploy