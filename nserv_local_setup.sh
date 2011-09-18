echo "
ssh $1 'nserv_deploy'
" > nserv

chmod +x nserv

mv nserv /usr/local/bin/nserv