settings
========

Gyuha's Linux Setting...

## Installation

Simply copying and pasting the following line into a terminal.

#Ubuntu 16.04

## 기본 서비스 패키지 설치

### 리눅스 사용자 설정
리눅스 터미널용 설정.
```bash
sudo apt-get install git vim curl
wget -O - https://raw.github.com/gyuha/settings/master/bootstrap.sh | bash
# 또는
wget -O - https://goo.gl/ti6IoK | bash

# Powerline 설정
wget -O - https://raw.github.com/gyuha/settings/master/bootstrap.sh | bash -s -- -p
```

-----
## Server Install

### 각종 유틸리티 설치
```bash
cd ~/.settings
sudo ./install_utility.sh
```

### node js 설치
```
cd ~/.settings
sudo ./install_nodejs.sh [VERSION]
```

### php-fpm & nginx 설치
```
cd ~/.settings
sudo ./install_nginx_phpfpm.sh
# 설정 파일 설치
sudo ./install_nginx_phpfpm.sh copyconf
```

### java 8 설치
```
cd ~/.settings
sudo ./install_utility.sh java
```

-----
## vim 설정

## Vim bootstrap 사용
```
curl 'http://vim-bootstrap.com/generate.vim' --data 'langs=javascript&langs=php&langs=html&langs=go&langs=python&editor=vim' > ~/.vimrc
ln ~/.settings/vimrc.local ~/.vimrc.local
```

## 마지막 버전으로 업데이트
vim에서 아래와 같이 사용합니다.
```
:VimBootstrapUpdate
:PlugInstall
```

## 참고
* https://vim-bootstrap.com/
* http://vim.spf13.com/


-----
## Desktop

### Desktop 어플리케이션 설치
```
cd ~/.settings
sudo ./install_desktop_app.sh
# 어플케이션 설정 복사
./install_desktop_app copyconf
```
