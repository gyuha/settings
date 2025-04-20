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
	#
	#  - btop : 시스템 사용 확인
	apt install -y inxi htop btop

	#  - ncdu : 폴더 사용 용량 확인 툴
	apt install -y ncdu duf

	# network
	#  - namp : port Scanning 툴로서 호스트나 네트워크를 스캐닝
	#    - 내부망 IP확인 : nmap -sn 192.168.0.0/24
	#  - net-tools : 네트워크 툴 netstate
	#  - iftop : 네트워크 용 top
	apt install -y net-tools nmap iftop

	# Text
	apt install -y dos2unix

	# Database tools
	#apt install -y mongodb-clients
	#apt install -y mycli
	#apt install -y redis-tools

	# exuberant-ctags : build tag file indexes of source code definitions
	# ncurses-term : 추가 터미널 타입 정의

	# https://switowski.com/blog/favorite-cli-tools
	apt install -y fd-find
	apt install -y ripgrep
	apt install -y autojump
	apt install -y bat
	apt install -y tree

	# https://github.com/scop/bash-completion
	apt install -y bash-completion

	# DNS 검색 유틸 dig 설치 용
	# https://www.ibm.com/docs/ko/aix/7.2?topic=d-dig-command
	apt install -y bind9-utils

	if [ -f $(which fdfind) ]; then
		ln -s $(which fdfind) /usr/local/bin/fd
	fi

	if [ -f $(which batcat) ]; then
		ln -s $(which batcat) /usr/local/bin/bat
	fi
}

# fzf is a general-purpose command-line fuzzy finder.
fzf() {
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}


# Python UV로 변경
#  https://github.com/astral-sh/uv
python() {
	# curl -fsSL https://pyenv.run | bash
	curl -LsSf https://astral.sh/uv/install.sh | sh
}

# Java 8 install
java() {
	repo_add "ppa:webupd8team/java"
	apt_add oracle-java8-installer
}

vimconfig() {
	wget -O - https://raw.githubusercontent.com/gyuha/vim-start/master/vimrc > ~/.vimrc
}


if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	apt update
	utility;
	fzf;
	python;
	exit;
fi

source ./lib/install_start.sh
