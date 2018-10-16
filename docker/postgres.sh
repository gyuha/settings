#!/bin/bash
# 참고 : https://gongzza.github.io/docker/db-sample/#postgres
#if [ $UID -ne 0 ]; then
	#echo Non root user. Please run as root.
	#exit 1;
#fi

VOLUME_NAME=postgres.data

function usage()
{
	echo "Install PostgreSQL by docker
Usage: `basename $0` [-h] POSTGRESQL_PASSWORD
	-h : help
	POSTGRESQL_PASSWORD : database postgre account password"
}

# 기본 postgresql 만들기
function createVolume()
{
	dbexist=$(docker volume ls|awk '{print $2}'|grep $VOLUME_NAME)
	if [ ! -n "$dbexist" ]; then
		echo "Create PostgreSQL voume"
		docker volume create $VOLUME_NAME
	fi
}

case "$1" in
	"-h")
		usage;
		exit 0;
		;;
esac

echo -n "Input PostgreSQL Password : "
read -s password
echo

createVolume;

docker run -p 5432:5432 \
       	--restart=always \
	--volume $VOLUME_NAME:/var/lib/postgresql/data \
	--name postgres \
	-e POSTGRES_INITDB_ARGS="--data-checksums -E utf8 --no-locale" \
	-e POSTGRES_PASSWORD=$password \
	-d postgres:latest
