#!/bin/bash
#if [ $UID -ne 0 ]; then
	#echo Non root user. Please run as root.
	#exit 1;
#fi

NAME=redis
VOLUME_NAME=$NAME.data

function usage()
{
	echo "Install MariaDB by docker
Usage: `basename $0` [-h] ROOT_PASSWORD
	-h : help
	ROOT_PASSWORD : database root account password"
}

# 기본 mariadb 만들기
function createVolume()
{
	dbexist=$(docker volume ls|awk '{print $2}'|grep $VOLUME_NAME)
	if [ ! -n "$dbexist" ]; then
		echo "Create $NAME voume"
		docker volume create $VOLUME_NAME
	fi
}

case "$1" in
	"-h")
		usage;
		exit 0;
		;;
esac

echo -n "Input $NAME Password : "
read -s password
echo

createVolume;

docker run -p 6379:6379 --restart=always \
	--name $NAME \
	-e REDIS_PASSWORD=$password \
	-v $VOLUME_NAME:/bitnami/redis/data \
	bitnami/redis:latest
