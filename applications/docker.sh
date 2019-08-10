#!/usr/bin/env bash
if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

apt update
apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt update
apt-cache policy docker-ce
apt -y install docker-ce
