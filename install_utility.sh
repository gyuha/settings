#!/usr/bin/env bash

source ./install_common.sh

root_require;

# Utillity install
utility() {
	apt install -y cronolog vim ctags git build-essential g++ curl
	apt install -y libssl-dev expect tmux
	apt install -y gawk cmake
	apt install -y exuberant-ctags ncurses-term
	apt install -y inxi htop net-tools
	apt install -y dos2unix

	# inxi : 시스템 사양 확인 / Ex) inxi -F
	# htop : 시스템 사용 확인
	# exuberant-ctags : build tag file indexes of source code definitions
	# ncurses-term : 추가 터미널 타입 정의
}


# Python3
python3() {
	apt install -y python3-dev
	apt install -y python3-pip
	apt install -y python3-virtualenv
	apt install -y python3-bs4
}

# Java 8 install
java() {
	repo_add "ppa:webupd8team/java"
	apt_add oracle-java8-installer
}

# mysql 5.6 install
mysql() {
	apt install -y mysql-server-5.6 mysql-client-5.6
}

# mariadb install
mariadb() {
	apt install -y mariadb-server mariadb-client
}

# Docker
docker() {
	apt install -y docker.io
}

# mongodb install
mongodb() {
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
	echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
	apt_add mongodb-org
}


if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	utility;
	docker;
	run_all;
	exit;
fi

install_start;
