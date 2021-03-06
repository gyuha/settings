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
	msg  "Copy Mpv settings"
	cp -rf ./conf/mpv ~/.config
	echo  "Complete"
}

terminator() {
	msg  "Copy terminator settings"
	cp -rf ./conf/terminator ~/.config
	echo  "Complete"
}

goldendict() {
	msg  "Copy GoldenDict settings"
	cp -rf ./conf/goldendict ~/.goldendict
	echo  "Complete"
}

geany;
doublecmd;
mcomix;
mpv;
terminator;
goldendict;
