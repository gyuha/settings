#!/usr/bin/env bash
set -e

if [ $UID -eq 0 ]; then
	echo You are root. Please run home user.
	exit 1;
fi

VERSION=1.14.2
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

BASH_RC=~/.bashrc

echo "" >> $BASH_RC
echo "export GOROOT=/usr/local/go" >> $BASH_RC
echo "export GOPATH=${HOME}/go" >> $BASH_RC
echo "export PATH=\${PATH}:\${GOPATH}/bin:\${GOROOT}/bin" >> $BASH_RC

ZSH_RC=~/.bashrc

echo "" >> $ZSH_RC
echo "export GOROOT=/usr/local/go" >> $ZSH_RC
echo "export GOPATH=${HOME}/go" >> $ZSH_RC
echo "export PATH=\${PATH}:\${GOPATH}/bin:\${GOROOT}/bin" >> $ZSH_RC

mkdir -p ~/go/bin
mkdir -p ~/go/src

echo -e "Type this \\n\\t# source ${BASH_RC}"
