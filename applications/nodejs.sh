#!/usr/bin/env bash
NVS_HOME="$HOME/.nvs"
git clone https://github.com/jasongin/nvs "$NVS_HOME"
. "$NVS_HOME/nvs.sh" install
echo "nvs auto on" >> ~/.zshrc
nvs add lts
nvs use lts
nvs link lts


npm install -g yarn
# Typescript
npm install -g typescript ts-node tslint
npm install -g typescript-language-server
# gtop : 시스템 모니터링 - https://www.npmjs.com/package/gtop
npm install -g gtop
# 간이 http-server
npm install -g http-server

# node 프로세스 메니저
# npm install -g pm2

# pm2 plugins
# pm2 install typescript ts-node
# pm2 로거 설정
# pm2 install pm2-logrotate
# 로그는 60일만 보관
# pm2 set pm2-logrotate:retain 60

node -v
yarn -v
npm -v
tsc -v
