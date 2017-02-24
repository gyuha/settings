#!/usr/bin/env bash
set -e

if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

VERSION=6
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
