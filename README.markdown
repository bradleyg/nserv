Nserv wants to be a [Nodejitsu](http://nodejitsu.com/) / [Heroku](http://www.heroku.com/) / [No.de](https://no.de/) / [AppFog](http://appfog.com/) style PaaS for deploying node.js applciations which can be hosted on your own servers. Nserv uses [nodejitsu](http://nodejitsu.com/#technology) applications [forever](https://github.com/indexzero/forever) and [node-http-proxy](https://github.com/nodejitsu/node-http-proxy) so is running almost entirely on nodejs. A total works in progress, probably with a lot of bugs.

## Features:
* Easy install in two lines
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

Point a domain name to your server or add one to /etc/hosts:
[http://jorgebernal.info/2009/07/17/42foo-virtual-hosts-web-development/](http://jorgebernal.info/2009/07/17/42foo-virtual-hosts-web-development/)

## Usage:

`./nserv create (domain)`  
`./nserv delete (domain)`  
`./nserv list`  
`./nserv help`
  
After adding an application you will be provided with a git remote that you can add to your local repo. Once added execute `git push nserv master` and your server will updated. For now your main server file must be called 'server.js'. If you provide a package.json file for npm modules add a .gitignore file to remove your node\_modules folder. Npm is installed on nserv and installs dependencies automatically. 

## TODO:
* Use a Procfile to choose the main application file
* Allow install via npm

## Good stuff:
[npm](http://npmjs.org/)  
[nodejitsu](http://nodejitsu.com/#technology)  