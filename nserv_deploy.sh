#!/bin/bash

breaker="\e[0;37m"
success="\e[0;32m"
message="\e[0;33m"
question='\e[0;36m'
error='\e[0;31m'
title='\e[0;35m'
bashme='\e[0;30m'
reset="\033[0m"

echo ""
echo -e "${title}NSERV.${reset} NodeJS server & deployment ${breaker}- https://github.com/bradleyg/nserv${reset}"
echo -e "${breaker}---------------------------------------------------${reset}"
echo -e "${message}Installed applications:${reset}"

cd www
ls -1
echo -e "${breaker}---------------------------------------------------${reset}"
echo -e "${question}Please enter the domain name to add/delete. (example.com):${reset}"
read domain

cd ..

if [ "$domain" == "" ]; then
	echo -e "${error}You didn't enter a domain. Exiting.${reset}"
	exit
fi

if [ -d ~/www/$domain ]; then
	echo -e "${breaker}---------------------------------------------------${reset}"
	echo -e "${question}Are you sure you want to delete $domain? (y/n):${reset}"
	read option
	if [ "$option" == "n" ]; then
		echo -e "${breaker}---------------------------------------------------${reset}"
		echo -e "${message}$domain not modified${reset}"
		echo -e "${breaker}---------------------------------------------------${reset}"
		exit
	elif [ "$option" == "y" ]; then
		export choice="delete"
	else
		echo -e "${breaker}---------------------------------------------------${reset}"
		echo -e "${error}Incorrect option${reset}"
		echo -e "${breaker}---------------------------------------------------${reset}"
		exit	
	fi
else
	export choice="add"
fi

function get_port {
	export random_number=$[ ( $RANDOM % 1000 )  + 9000 ]
	export checkport=$(netstat -tulpn | grep 0.0.0.0:$random_number)
	if [ -n "$checkport" ]; then
		get_port
	fi
}

if [ "$choice" == "add" ]; then
	echo -e "${breaker}---------------------------------------------------${reset}"
	echo -e "${message}Adding domain $domain.......${reset}"
	echo -e "${breaker}---------------------------------------------------${reset}"
	get_port
	mkdir ~/www/$domain
	mkdir ~/www/$domain/repo
	mkdir ~/www/$domain/app
	cd ~/www/$domain/repo
	git init --bare --quiet
	echo "	
	echo ''
	echo 'NSERV. NodeJS server & deployment - https://github.com/bradleyg/nserv'
	echo '---------------------------------------------------'
	echo 'Updating application.......'
	echo '---------------------------------------------------'
	GIT_WORK_TREE=~/www/$domain/app
	export GIT_WORK_TREE
	git checkout -f
	echo 'Stopping server.......'
	forever stop ~/www/$domain/app/server.js
	echo '---------------------------------------------------'	
	cd ~/www/$domain/app/
	echo 'Installing NPM modules......'
	npm install -d
	npm prune
	echo '---------------------------------------------------'
	echo 'Restarting server.......'
	PORT=$random_number forever start ~/www/$domain/app/server.js
	echo '---------------------------------------------------'
	echo 'Application updated.'
	echo '---------------------------------------------------'
	echo ''
	" >  ~/www/$domain/repo/hooks/post-receive
	chmod +x hooks/post-receive
	sed -e "s/router: {/router: {'$domain':'127.0.0.1:$random_number',/g" ~/server/www.js -i
	echo -e "${message}Restarting server.......${reset}"
	echo -e "${breaker}---------------------------------------------------${reset}"
	forever stop ~/server/www.js &>/dev/null
	forever start ~/server/www.js &>/dev/null
	echo "
	var http = require('http');
	http.createServer(function (req, res) {
	  res.writeHead(200, { 'Content-Type': 'text/plain' });
	  res.write('Application successfully added. Commit changes to update you application.');
	  res.end();
	}).listen(process.env.PORT);
	" > ~/www/$domain/app/server.js
	PORT=$random_number forever start ~/www/$domain/app/server.js &>/dev/null
	echo -e "${success}Domain $domain added. Please add the following as a git remote:${reset}"
	echo -e "${bashme}> git remote add nserv ssh://$1/~/www/$domain/repo${reset}"
	echo ""
	echo -e "${success}Then push to nserv:${reset}"
	echo -e "${bashme}> git push nserv master${reset}"
	echo -e "${breaker}---------------------------------------------------${reset}"
elif [ "$choice" == "delete" ]; then
	echo -e "${breaker}---------------------------------------------------${reset}"
	echo -e "${message}Removing domain $domain.......${reset}"
	echo -e "${breaker}---------------------------------------------------${reset}"
	rm -rf ~/www/$domain
	sed -e "s/'$domain':'127.0.0.1:.*',//g" ~/server/www.js -i
	forever stop ~/www/$domain/app/server.js &>/dev/null
	forever stop ~/server/www.js &>/dev/null
	echo -e "${message}Restarting server.......${reset}"
	echo -e "${breaker}---------------------------------------------------${reset}"
	forever start ~/server/www.js &>/dev/null
	echo -e "${success}Domain $domain removed.${reset}"
	echo -e "${breaker}---------------------------------------------------${reset}"
fi

echo ""