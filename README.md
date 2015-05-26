settings
========

Gyuha's Linux Setting...

## Installation

Simply copying and pasting the following line into a terminal.

#Ubuntu 14.04

### 기본 서비스 패키지 설치

#### 

    wget -O - https://raw.github.com/gyuha/settings/master/start.sh | bash

#### 리눅스 사용자 설정
vim 및 리눅스 터미널용 설정.

    wget -O - https://raw.github.com/gyuha/settings/master/vim_bootstrap.sh | bash

-----
### Server

#### php-fpm 개발 환경
nodejs, java, nginx, vim, mysql, php-fpm 등 웹서비스에 필요한 패키지들 설치

    wget -O - https://raw.github.com/gyuha/settings/master/phpfpm.sh | sudo bash -s all

#### 설정 파일 설치

    wget -O - https://raw.github.com/gyuha/settings/master/phpfpm.sh | sudo bash -s copyconf


-----
### Desktop

#### Desktop 어플리케이션 설치

    wget -O - https://raw.github.com/gyuha/settings/master/desktop.sh | sudo bash -s all

#### 어플케이션 설정 복사
리눅스 사용자 설정을 한 이후에 해야 함.

    cd ~/.settings
	./ubuntu_14.04_desktop.sh copyconf

