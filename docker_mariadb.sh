#!/bin/bash
if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

function usage()
{
	echo "Install MariaDB by docker
Usage: `basename $0` [-h] ROOT_PASSWORD
	-h : help
	ROOT_PASSWORD : database root account password"
}

case "$1" in
	"-h")
		usage;
		exit 0;
		;;
esac

# 만약 파라메터 2개가 아니면 종료
[ $# -lt 1 ] && usage && exit 1

docker run -p 3306:3306 --restart=always --name mariadb -e MYSQL_ROOT_PASSWORD=$1 -d mariadb:latest
