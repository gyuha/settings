#!/bin/bash
# Remove docker container

function usage()
{
	echo -e "Remove docker container
Usage: `basename $0` [-a OR ID OR name] [-h]
	-a : remove all containers
	-h : help
	"
}

case "$1" in
	"-h")
		usage;
		exit 0;
		;;
	"-a")
		docker stop $(docker ps -q)
		docker rm $(docker ps -a -q)
		exit 0;
		;;
esac

docker stop $1
docker rm $1
docker rmi $1
# Remove all unused local volumes
docker volume prune -f
