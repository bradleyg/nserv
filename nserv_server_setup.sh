export LANG=en_GB
export LC_ALL=C
locale-gen $LANG
echo LANG=$LANG >> /etc/environment
echo LC_ALL=$LC_ALL >> /etc/environment

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install build-essential
sudo apt-get -y install git-core

sudo apt-get -y install python-software-properties
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get -y update
sudo apt-get -y install nodejs
sudo apt-get -y install nodejs-dev

curl http://npmjs.org/install.sh | sh

npm install forever -g

mkdir ~/server
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