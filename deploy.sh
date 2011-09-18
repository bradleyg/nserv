echo "Do you want to add or remove a domain? (a/r):"
read option

if [[ "$option" != "a" && "$option" != "r" ]]; then
	echo "Incorrect option"
	exit
fi

echo "Please enter the domain name. (example.com):"
read domain

if [ "$domain" == "" ]; then
	echo "You didn't enter a domain"
	exit
fi

function get_port {
	export random_number=$[ ( $RANDOM % 1000 )  + 9000 ]
	echo "Port Number $random_number"
	export checkport=$(netstat -tulpn | grep 0.0.0.0:$random_number)
	if [ -n "$checkport" ]; then
  		echo "Port already in use"
		get_port
	fi
}

if [ "$option" == "a" ]; then
	echo "Adding $domain"
	get_port
	mkdir ~/www/$domain
	mkdir ~/www/$domain/repo
	mkdir ~/www/$domain/app
	cd ~/www/$domain/repo
	git init --bare
	echo "
	GIT_WORK_TREE=~/www/$domain/app
	export GIT_WORK_TREE
	git checkout -f
	forever stop ~/www/$domain/app/server.js
	cd ~/www/$domain/app/
	npm install -d
	npm prune
	PORT=$random_number forever start ~/www/$domain/app/server.js
	" >  ~/www/$domain/repo/hooks/post-receive
	chmod +x hooks/post-receive
	sed -e "s/router: {/router: {'$domain':'127.0.0.1:$random_number',/g" ~/server/www.js -i
elif [ "$option" == "r" ]; then
	rm -rf ~/www/$domain
	sed -e "s/'$domain':'127.0.0.1:.*',//g" ~/server/www.js -i
	forever stop ~/www/$domain/app/server.js
fi

forever stop ~/server/www.js
forever start ~/server/www.js
