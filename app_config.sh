#!/usr/bin/env bash

geany() {
	echo  "Copy Geany settings"
	cp -rf ./conf/geany/colorschemes ~/.config/geany
	echo  "Complete"
}

doublecmd() {
	echo  "Copy Double Commander settings"
	cp -rf ./conf/doublecmd ~/.config
	echo  "Complete"
}

mcomix() {
	echo  "Copy MComix settings"
	cp -rf ./conf/mcomix ~/snap/mcomix-tabetai/current/.config/
	echo  "Complete"
}

geany;
doublecmd;
mcomix;
