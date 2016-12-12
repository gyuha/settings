#!/usr/bin/env bash
set -e

if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

<<<<<<< HEAD
VERSION=7
=======
VERSION=6
>>>>>>> 81975282da7e3c856b42e34dd271c8d5f90f2dbe
if [ -n "$1" ]; then
	VERSION=$1
fi

re='^[0-9]+$'
if ! [[ $VERSION =~ $re ]]; then
	echo "Version is number"
	exit 1
fi

curl -sL https://deb.nodesource.com/setup_$VERSION.x | bash -s
apt-get install -y nodejs
