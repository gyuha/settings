#!/usr/bin/env bash

MAGENTA='\e[0;35m'
END_COLOR='\e[0m'

msg() {
	printf $MAGENTA'%b\n'$END_COLOR "$1" >&2
}

geany() {
	msg  "Copy Geany settings"
	cp -rf ./conf/geany/colorschemes ~/.config/geany
	echo "Complete"
}

doublecmd() {
	msg  "Copy Double Commander settings"
	cp -rf ./conf/doublecmd ~/.config
	echo  "Complete"
}

mcomix() {
	msg  "Copy MComix settings"
	cp -rf ./conf/mcomix ~/snap/mcomix-tabetai/current/.config/
	echo  "Complete"
}

mpv() {
	msg  "Copy MComix settings"
	cp -rf ./conf/mpv ~/.config
	echo  "Complete"
}

geany;
doublecmd;
mcomix;
mpv;
