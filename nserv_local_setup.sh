#!/bin/bash

echo '
#!/bin/bash
clear
ssh $1 "nserv_deploy $1"
' > nserv
chmod +x nserv
mv nserv /usr/local/bin/nserv