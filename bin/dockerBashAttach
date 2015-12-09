#!/bin/bash

function usage()
{
	echo "Docker attach terminal
Usage: `basename $0` [-h] [ID or name]
	-h : help "
}

case "$1" in
	"-h")
		usage;
		exit 0;
		;;
esac

# 만약 파라메터 2개가 아니면 종료
[ $# -lt 1 ] && usage && exit 1

docker exec -i -t $1 bash
