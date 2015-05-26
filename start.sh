#!/usr/bin/env bash

if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

BLACK='\e[0;30m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'
END_COLOR='\e[0m'

# apt-repository array
REPOS=()
APTS=()

# apt-repository array
REPOS=()
APTS=()

apt_add() {
	for p in $*;
	do
		APTS+=($p)
	done;
}

repo_add() {
	for p in $*;
	do
		REPOS+=($p)
	done;
}
# BASIC SETUP TOOLS
msg() {
	printf $MAGENTA'%b\n'$END_COLOR "$1" >&2
}

success() {
	echo -e "$GREEN[✔]$END_COLOR ${1}${2}"
}

error() {
	msg "$RED[✘]$END_COLOR ${1}${2}"
	exit 1
}

debug() {
	if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
	  msg "An error occured in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
	fi
}


program_exists() {
	local ret='0'
	type $1 >/dev/null 2>&1 || { local ret='1'; }

	# throw error on non-zero return value
	if [ ! "$ret" -eq '0' ]; then
	error "$2"
	fi
}

function_exists() {
	declare -f -F $1 > /dev/null
	return $?
}



update() {
	msg "Ubuntu update start."
	apt-get update
	apt-get upgrade
	success "Update Complete"
}

run_all() {
	apt_add python-software-properties software-properties-common

	for p in ${REPOS[@]};
	do
		add-apt-repository -y $p
	done;

	update;

	for p in ${APTS[@]};
	do
		msg "$p Install.."
		apt-get install -y $p
	done;
	success "Complete"
}

###############################
# Functions {{

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


# Functions }}
################################

if [ $# -eq 0 ]; then
	msg "Select any packages.";
	exit;
fi

if [ $1 == "all" ]; then
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

RUN=false;
for (( i=1;$i<=$#;i=$i+1 ))
do
	function_exists ${!i} && eval ${!i} && RUN=true || msg "Can't find function..";
done
if $RUN eq true
then
	run_all;
fi
