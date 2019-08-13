#!/usr/bin/env bash
set -e

if [ $UID -eq 0 ]; then
	echo You are root. Please run home user.
	exit 1;
fi

VERSION=12
if [ -n "$1" ]; then
	VERSION=$1
fi

re='^[0-9]+$'
if ! [[ $VERSION =~ $re ]]; then
	echo "Version is number"
	exit 1
fi

sudo curl -sL https://deb.nodesource.com/setup_$VERSION.x | sudo -E bash -
sudo apt install -y nodejs

# node 로컬 계정 설정
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo "export PATH=~/.npm-global/bin:\$PATH" >> ~/.bashrc

npm install -g yarn
# Typescript
npm install -g typescript ts-node tslint
# gtop : 시스템 모니터링 - https://www.npmjs.com/package/gtop
npm install -g gtop
# node 포로세스 메니저
npm install -g pm2
# 간이 http-server
npm install -g http-server
# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

node -v
npm -v
tsc -v
