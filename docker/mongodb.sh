#!/bin/bash
# 참고
# - https://medium.com/@itseranga/enable-mongodb-authentication-with-docker-1b9f7d405a94
# - https://www.mkyong.com/mongodb/mongodb-authentication-example/
# CLI login
#  > mongo -u admin -p [password] --authenticationDatabase admin
#if [ $UID -ne 0 ]; then
	#echo Non root user. Please run as root.
	#exit 1;
#fi

PS_NAME=mongodb
VOLUME_NAME=mongodb.data

function usage()
{
	echo "Install MongoDB by docker
Usage: `basename $0` [-h]
	-h : help"
}

case "$1" in
	"-h")
		usage;
		exit 0;
		;;
esac



# 기본 mongodb 만들기
function createVolume()
{
	dbexist=$(docker volume ls|awk '{print $2}'|grep $VOLUME_NAME)
	if [ ! -n "$dbexist" ]; then
		echo "Create mongodb voume"
		docker volume create $VOLUME_NAME
	fi
}


echo -n "Input $PS_NAME Password : "
read -s password
echo


createVolume;

PW=""
if [ -n "$password" ]; then
	PW="-e MONGO_INITDB_ROOT_USERNAME=root \
	-e MONGO_INITDB_ROOT_PASSWORD=$password "
fi

# docker run -p 27017:27017 --restart=always --name $PS_NAME -d -v $VOLUME_NAME:/data/db mongo:latest
docker run -p 27017:27017 \
	--restart=always \
	--name $PS_NAME $PW \
	-d -v $VOLUME_NAME:/data/db \
	mongo:latest


echo "connect to : mongodb://root:$password@localhost:27017/admin"
