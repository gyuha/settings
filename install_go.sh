#!/usr/bin/env bash
set -e

#if [ $UID -ne 0 ]; then
	#echo Non root user. Please run as root.
	#exit 1;
#fi

VERSION=1.11
if [ -n "$1" ]; then
	VERSION=$1
fi

re='^[0-9.]+$'
if ! [[ $VERSION =~ $re ]]; then
	echo "Version is number"
	exit 1
fi

FILE=go$VERSION.linux-amd64.tar.gz
URL=https://dl.google.com/go/$FILE
cd /tmp
wget $URL

tar -xvf $FILE
sudo mv go /usr/local
rm $FILE

echo "export GOROOT=/usr/local/go" >> ~/.bashrc
echo "export GOPATH=${HOME}/go" >> ~/.bashrc
echo "export PATH=\${PATH}:\${GOPATH}/bin:\${GOROOT}/bin" >> ~/.bashrc
mkdir -p ~/go/bin
mkdir -p ~/go/src

echo -e "Type this \\n\\t# source $PROFILE"
