#!/bin/bash
# Read Password

if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

MAGENTA='\e[0;35m'
RED='\e[0;31m'
END_COLOR='\e[0m'

echo -e "$MAGENTA
###############################################
#  NOTICE : Only User development service...  #
############################################### $END_COLOR
"

echo -n MySQL Password:
read -s password
echo

echo -e "$MAGENTA>> Mysql bind-address all ip.. $END_COLOR"
sed -i 's/^bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf
# Run Command

query="
UPDATE user SET plugin='', password=password('$password');\n
INSERT INTO user (Host, User, Password) VALUES ('%', 'root', password('$password'));\n
FLUSH privileges;\n
GRANT ALL privileges ON \052.\052 TO root@'%' IDENTIFIED BY '$password';\n
FLUSH privileges;\n
"

echo -e "$MAGENTA>> User add AND connect setting.. $END_COLOR"
echo -e $query |mysql -uroot -p$password mysql
echo -e "$MAGENTA>> Mysql restart $END_COLOR"
service mysql restart
