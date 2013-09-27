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

disableUnnecessayErrorMessage() {
	msg "Disable Unnecessary Error Messages from Appearing"
    sed -i "s/enabled=1/enabled=0/" /etc/default/apport
	restart apport
	success "Complete"
}

uiTweakTools() {
	msg "Install Compiz Config Settings Manager (CCSM)"
	apt-get install -y compizconfig-settings-manager unity-tweak-tool gnome-tweak-tool
	success "Complete"
}

cpuMemIndicator() {
	msg "Install CPU/Memory Indicator Applet"
	add-apt-repository -y ppa:indicator-multiload/stable-daily
	apt-get update
	apt-get install -y indicator-multiload
	success "Complete"
}

freeUpSpace() {
	msg "Freeing Up Disk Space"
	du -sh /var/cache/apt/archives:w
	apt-get clean
	success "Complete"
}

removeLens() {
	msg "Remove Lens"
	apt-get remove -y unity-lens-shopping unity-lens-music unity-lens-photos  unity-lens-gwibber unity-lens-video
	success "Complete"
}

flash() {
	msg "Install Adobe Flash Plugin"
	apt-get install -y flashplugin-installer
	success "Complete"
}

torrent() {
	msg "Install qBittorrent"
	apt-get install -y qbittorrent
	success "Complete"
}

copyQ() {
	msg "Install Copyq Indicator"
	add-apt-repository -y ppa:samrog131/ppa
	apt-get update
	apt-get install -y copyq
	success "Complete"
}

media() {
	msg "Install VLC"
	apt-get install -y vlc audacious goldendict
	success "Complete"
}

dictionary() {
	msg "Install dictionary"
	apt-get install -y goldendict
	success "Complete"
}

gimp() {
	msg "Install gimp"
	apt-get install -y gimp
	success "Complete"
}

restrictedExtras() {
	msg "Install Ubuntu Restricted Extras"
	apt-get install -y ubuntu-restricted-extras libavformat-extra-53 libavcodec-extra-53
	success "Complete"
}

mysqlworkbench() {
	msg " Install mysql-workbench"
	apt-get install -y mysql-workbench
	success "Complete"
}

serviceManager() {
	msg "Install Service Manager"
	apt-get install -y bum rcconf
	success "Complete"
}

googleCalendar() {
	msg "Install Google Calendar Indicator"
	add-apt-repository -y ppa:atareao/atareao
	apt-get update
	apt-get install -y calendar-indicator
	success "Complete"
}

compression() {
	msg " Install Compression/Decompression tools"
	apt-get install -y p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller
	success "Complete"
}

guiDevTools() {
	msg " Install GUI Dev Tools"
	apt-get install -y gitg rapidsvn
	success "Complete"
}

if [ $# -eq 0 ]; then
	msg "Select any packages.";
	exit;
fi

if [ $1 == "all" ]; then
	msg "Install all packages."
	disableUnnecessayErrorMessage;
	serviceManager;
	uiTweakTools;
	cpuMemIndicator;
	removeLens;
	flash;
	torrent;
	copyQ;
	media;
	dictionary;
	gimp;
	restrictedExtras;
	googleCalendar;
	compression;
	guiDevTools;
	#freeUpSpace;
	msg "Complete."
	exit;
fi

for (( i=1;$i<=$#;i=$i+1 ))
do
	function_exists ${!i} && eval ${!i} || msg "Can't find function..";
done
