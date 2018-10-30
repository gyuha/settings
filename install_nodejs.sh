#!/usr/bin/env bash
set -e

if [ $UID -eq 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

VERSION=10
if [ -n "$1" ]; then
	VERSION=$1
fi

re='^[0-9]+$'
if ! [[ $VERSION =~ $re ]]; then
	echo "Version is number"
	exit 1
fi

sudo curl -sL https://deb.nodesource.com/setup_$VERSION.x | sudo -E bash -
sudo apt-get install -y nodejs
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo "export PATH=~/.npm-global/bin:\$PATH" >> ~/.profile
npm install -g yarn
