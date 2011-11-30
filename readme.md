[![Build Status](https://secure.travis-ci.org/bradleyg/nserv.png)](http://travis-ci.org/bradleyg/nserv)  

Nserv wants to be a [Nodejitsu](http://nodejitsu.com/) / [Heroku](http://www.heroku.com/) / [No.de](https://no.de/) style PaaS for deploying node.js applciations which can be hosted on your own servers. Nserv uses [nodejitsu](http://nodejitsu.com/#technology) applications [forever](https://github.com/indexzero/forever) and [node-http-proxy](https://github.com/nodejitsu/node-http-proxy) so is running entirely on nodejs. A total works in progress, probably with a lot of bugs.

## Features:
* Git deployment of applications
* Simple management of deployed applications

## Setup:
* Create a fresh ubuntu 10.04 instance, linode or rackspace is good: [http://library.linode.com/getting-started##sph_deploy-a-linux-distribution](http://library.linode.com/getting-started##sph_deploy-a-linux-distribution)  
* Point a domain name to your server or add one to /etc/hosts: [http://jorgebernal.info/2009/07/17/42foo-virtual-hosts-web-development/](http://jorgebernal.info/2009/07/17/42foo-virtual-hosts-web-development/)  
* `sudo npm install forever -g`  
* `sudo npm install nserv -g`  

## Usage:
`[sudo] nserv start` - starts running the nserv service  
`[sudo] nserv stop`  
`nserv create (domain)` - this will add the domain to nserv proxy table and start proxying requests  
`nserv remove (domain)`  
`nserv list` - lists all applications  
`nserv help`
  
You must first start the nserv server: `sudo nserv start`, this will create a http proxy table and route any domains added to it via: `nserv create domain.com`. Sudo privileges are required so the proxy server can listen on port 80.   

After creating an application you will be shown a git remote within the console that you can add to your local repo. Once added execute `git push nserv master` and your app will be updated and restarted automatically.  

For now your main server file must be called 'server.js' and your app must listen on `process.env.PORT`. ~~If you provide a package.json file for npm modules add a .gitignore file to remove your node\_modules folder. Npm is installed on nserv and installs dependencies automatically.~~  

## TODO:
* Define the main server.js in the package.json
* Automatic install of npm modules
* Hard start and stop of applications (without the need to delete or update)  

## Good stuff:
[npm](http://npmjs.org/)  
[nodejitsu](http://nodejitsu.com/#technology)  