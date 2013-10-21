#!/usr/bin/env bash

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


# only local run..
copyconf() {
	msg "Copy application settings"
	cp -rf ./conf/geany/colorschemes ~/.config/geany
	cp -rf ./conf/terminator ~/.config/
	cp -rf ./conf/copyq  ~/.config/
	success "Complete"
}

if [ $1 == "copyconf" ]; then
	copyconf;
	exit;
fi


# 관리자만 실행.
if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

disableUnnecessayErrorMessage() {
	msg "Disable Unnecessary Error Messages from Appearing"
    sed -i "s/enabled=1/enabled=0/" /etc/default/apport
	restart apport
	success "Complete"
}

languagePack() {
	apt-get install -y language-pack-ko language-pack-gnome-ko language-pack-ko-base language-pack-gnome-ko-base
	check-language-support -l ko
}

uiTweakTools() {
	apt_add compizconfig-settings-manager unity-tweak-tool gnome-tweak-tool
}

cpuMemIndicator() {
	repo_add ppa:indicator-multiload/stable-daily
	apt_add indicator-multiload
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
	apt_add flashplugin-installer
}

torrent() {
	apt_add qbittorrent
}

copyQ() {
	repo_add ppa:samrog131/ppa
	apt_add copyq
}

media() {
	apt_add vlc audacious goldendict
	apt_add smplayer
}

dictionary() {
	apt_add -y goldendict
	# 다음 미니 영한사전 : http://engdic.daum.net/dicen/small_search.do?endic_kind=all&m=all&nil_profile=vsearch&nil_src=engdic&q=%GDWORD%
	# 다음 일반 영한사전: http://engdic.daum.net/dicen/search.do?endic_kind=all&m=all&nil_profile=vsearch&nil_src=engdic&q=%GDWORD%
}

gimp() {
	apt_add gimp
}

restrictedExtras() {
	# 여러가지 멀티 미디어에 쓰이는코덱과 폰트등을 설치해주는 도구
	apt_add ubuntu-restricted-extras libavformat-extra-53 libavcodec-extra-53
}

mysqlworkbench() {
	apt_add mysql-workbench
}

serviceManager() {
	apt_add bum rcconf
}

googleCalendar() {
	repo_add ppa:atareao/atareao
	apt_add calendar-indicator
}

utilities() {
	apt_add p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller
	apt_add gnome-commander libgnomevfs2-extra
	apt_add filezilla
	apt_add chromium-browser
	apt_add geany geany-common geany-plugins
	apt_add terminator
	apt_add gnome-do gnome-doc-utils gnome-do-plugins
}

powerlinefont() {
	msg "Install powerline font"
	cd /tmp
	wget https://github.com/eugeneching/consolas-powerline-vim/raw/master/CONSOLA-Powerline.ttf
	mv /tmp/CONSOLA-Powerline.ttf /usr/share/fonts/truetype
	fc-cache -f
	cd -
	success "Complete"
}


guiDevTools() {
	repo_add ppa:eugenesan/ppa
	apt_add gitg rapidsvn vim-gtk meld
	apt_add smartgit
	apt_add mysql-workbench
	success "Complete"
}

if [ $# -eq 0 ]; then
	msg "Select any packages.";
	exit;
fi

if [ $1 == "all" ]; then
	msg "Install all packages."
	disableUnnecessayErrorMessage;
	languagePack;
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
	utilities;
	guiDevTools;
	run_all;
	powerlinefont;
	#freeUpSpace;
	msg "Complete."
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
