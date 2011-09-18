Nserv wants to be a [Heroku](http://www.heroku.com/) / [No.de](https://no.de/) / [AppFog](http://appfog.com/) clone which can be hosted on your own servers. Nserv uses [forever](https://github.com/indexzero/forever) and [node-http-proxy](https://github.com/nodejitsu/node-http-proxy) so Nserv is entirely running on nodejs.

## Features:
* Easy install in three lines
* Git deployment of applications
* Automatic install of npm modules
* Simple management of deployed applications

## Setup:
Create a fresh ubuntu 10.04 instance, linode or rackspace is good:
[http://library.linode.com/getting-started##sph_deploy-a-linux-distribution](http://library.linode.com/getting-started##sph_deploy-a-linux-distribution)

Setup key pairs:
[http://library.linode.com/security/ssh-keys](http://library.linode.com/security/ssh-keys)

Create ssh config file so you can just "ssh myserver" and get access:
[http://www.karan.org/blog/index.php/2009/08/25/multiple-ssh-private-keys](http://www.karan.org/blog/index.php/2009/08/25/multiple-ssh-private-keys)

## Server setup (must be root)
`apt-get install curl`  
`curl https://raw.github.com/bradleyg/nserv/master/nserv_server_setup.sh | sh`

## Local setup (linux / osx)
`curl https://raw.github.com/bradleyg/nserv/master/nserv_local_setup.sh | sh`

## Usage (from local machine):

`nserv myserver`
