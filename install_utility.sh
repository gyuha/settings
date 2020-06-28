#!/usr/bin/env bash

source ./lib/install_common.sh

root_require;

# Utillity install
utility() {
	# 개발 관련
	apt install -y cronolog vim ctags git tig build-essential g++ curl
	apt install -y gawk cmake
	apt install -y exuberant-ctags ncurses-term
	# Tig 설정
	ln -snf `pwd`/conf/tigrc ~/.tigrc

	apt install -y libssl-dev expect tmux

	# System
	#  - inxi : 시스템 사양 확인 / Ex) inxi -F
	#  - htop : 시스템 사용 확인
	apt install -y inxi htop

	# network
	#  - namp : port Scanning 툴로서 호스트나 네트워크를 스캐닝
	#    - 내부망 IP확인 : nmap -sn 192.168.0.0/24
	#  - net-tools : 네트워크 툴 netstate
	#  - iftop : 네트워크 용 top
	apt install -y net-tools nmap iftop

	# Text
	apt install -y dos2unix

	# Database tools
	apt install -y mongodb-clients
	apt install -y mycli
	apt install -y redis-tools

	# exuberant-ctags : build tag file indexes of source code definitions
	# ncurses-term : 추가 터미널 타입 정의

	# https://switowski.com/blog/favorite-cli-tools
	apt install -y fd-find
	apt install -y ripgrep
}

# fzf is a general-purpose command-line fuzzy finder.
fzf() {
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}


# Python3
python3() {
	apt install -y python3-dev
	apt install -y python3-pip
	apt install -y python3-venv
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

vimconfig() {
	curl https://raw.githubusercontent.com/gyuha/vim-start/master/vimrc > ~/.vimrc
}


if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	utility;
	fzf;
	run_all;
	# python3;
	# vimconfig;
	exit;
fi

source ./lib/install_start.sh
