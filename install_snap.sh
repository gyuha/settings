#!/usr/bin/env bash

# 설치 할 어플리케이션 검색 사이트
# https://snapcraft.io/store


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

# BASIC SETUP TOOLS
msg() {
	printf $MAGENTA'%b\n'$END_COLOR "$1" >&2
}


comic() {
	snap install mcomix-tabetai
}

vscode() {
	snap install vscode --classic
}

atom() {
	snap install sublime-text --classic
}

sublime_text() {
	snap install atom --classic
}

typora() {
	# Markdown editor
	snap install typora-alanzanattadev
}

android_studio() {
	snap install android-studio --classic
}

notepadqq() {
	snap install notepadqq
}

office() {
	snap install onlyoffice-desktopeditors
}

PACKAGES="all"
if [ $# -eq 1 ]; then
	PACKAGES=$1
fi

if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	comic;
	vscode;
	atom;
	sublime_text;
	typora;
	#android_studio;
	#office;
	notepadqq;
	msg "Complete.";
	exit;
fi

function_exists() {
	declare -f -F $1 > /dev/null
	return $?
}

for (( i=1;$i<=$#;i=$i+1 ))
do
	function_exists ${!i} && eval ${!i} && RUN=true || msg "${!i} Can't find function..";
done
