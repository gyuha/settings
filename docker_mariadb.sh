#!/bin/bash
#if [ $UID -ne 0 ]; then
	#echo Non root user. Please run as root.
	#exit 1;
#fi

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

echo -n "Input MySQL Password : "
read -s password
echo

echo -n "Input Database volume path : "
read path
echo $path

volume=""
if [ -n "$path" ]; then
	mkdir -p $path

	if [ ! -d $path ]; then
		echo "Can not make path : $path"
		exit
	fi
	volume=" --volume $path:/var/lib/mysql "
fi


docker run -p 3306:3306 --restart=always $volume --name mariadb -e MYSQL_ROOT_PASSWORD=$password -d mariadb:latest
