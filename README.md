settings
========

Gyuha's Linux Setting...

## Installation

Simply copying and pasting the following line into a terminal.

### curl 설치
기본 설치를 위해서 받아야 함.

    sudo apt-get install -y curl
-----
#Ubuntu 14.10

### 기본 서비스 패키지 설치

#### php-fpm 개발 환경
nodejs, java, nginx, vim, mysql, php-fpm 등 웹서비스에 필요한 패키지들 설치

    curl -L https://raw.github.com/gyuha/settings/master/phpfpm.sh | sudo bash -s all

#### 설정 파일 설치

    curl -L https://raw.github.com/gyuha/settings/master/phpfpm.sh | sudo bash -s copyconf

#### 리눅스 사용자 설정
vim 및 리눅스 터미널용 설정.

    curl -L https://raw.github.com/gyuha/settings/master/bootstrap.sh | bash


### Desktop 어플리케이션 설치

#### Ubuntu Desktop 14.10 어플리케이션 설치

    curl -L https://raw.github.com/gyuha/settings/master/desktop.sh | sudo bash -s all

#### 어플케이션 설정 복사
리눅스 사용자 설정을 한 이후에 해야 함.

    cd ~/.settings
	./ubuntu_14.04_desktop.sh copyconf

