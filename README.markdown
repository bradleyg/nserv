Nserv wants to be a [Nodejitsu](http://nodejitsu.com/) / [Heroku](http://www.heroku.com/) / [No.de](https://no.de/) / [AppFog](http://appfog.com/) style PaaS for deploying node.js applciations which can be hosted on your own servers. Nserv uses [nodejitsu](http://nodejitsu.com/#technology) applications [forever](https://github.com/indexzero/forever) and [node-http-proxy](https://github.com/nodejitsu/node-http-proxy) so is running entirely on nodejs. A total works in progress, probably with a lot of bugs.

## Features:
* Git deployment of applications
* Automatic install of npm modules
* Simple management of deployed applications

## Setup:
* Create a fresh ubuntu 10.04 instance, linode or rackspace is good: [http://library.linode.com/getting-started##sph_deploy-a-linux-distribution](http://library.linode.com/getting-started##sph_deploy-a-linux-distribution)  
* Point a domain name to your server or add one to /etc/hosts: [http://jorgebernal.info/2009/07/17/42foo-virtual-hosts-web-development/](http://jorgebernal.info/2009/07/17/42foo-virtual-hosts-web-development/)  
* `sudo npm install nserv -g`  

## Usage:
`[sudo] nserv start` - starts running the nserv service  
`[sudo] nserv stop`  
`nserv create (domain)` - this will add the domain to nserv proxy table and start proxying requests  
`nserv remove (domain)`  
`nserv list`  
`nserv help`
  
After adding an application you will be provided with a git remote that you can add to your local repo. Once added execute `git push nserv master` and your server will updated and restarted. For now your main server file must be called 'server.js'. If you provide a package.json file for npm modules add a .gitignore file to remove your node\_modules folder. Npm is installed on nserv and installs dependencies automatically. 

## TODO:
* Define the main server.js in the package.json

## Good stuff:
[npm](http://npmjs.org/)  
[nodejitsu](http://nodejitsu.com/#technology)  
