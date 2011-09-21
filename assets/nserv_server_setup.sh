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