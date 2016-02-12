#!/usr/bin/env bash

source ./installCommon.sh

openssh() {
	apt_add openssh-server
}

utillity() {
	# Utillity install
	apt_add cronolog vim ctags git subversion build-essential g++ curl libssl-dev sysv-rc-conf expect tmux htop rcconf mc iotop
}

# Java 8 install
java() {
	repo_add "ppa:webupd8team/java"
	apt_add oracle-java8-installer
}

if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	openssh;
	utillity;
	run_all;
	exit;
fi

if [ $1 == "copyconf" ]; then
	copyconf;
	exit;
fi

