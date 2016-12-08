#!/usr/bin/env bash

source ./install_common.sh

# Utillity install
utility() {
	apt_add cronolog vim ctags git subversion build-essential g++ curl libssl-dev sysv-rc-conf expect tmux htop rcconf
}

# Java 8 install
java() {
	repo_add "ppa:webupd8team/java"
	apt_add oracle-java8-installer
}

# mysql 5.6 install
mysql() {
	apt_add mysql-server-5.6 mysql-client-5.6
}

# mariadb install
mariadb() {
	apt_add mariadb-server mariadb-client
}


if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	utility;
	run_all;
	exit;
fi

source ./install_run.sh
