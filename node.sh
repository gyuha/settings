#!/usr/bin/env bash

if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install nodejs

