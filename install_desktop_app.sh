#!/usr/bin/env bash

source ./install_common.sh

# only local run..
copyconf() {
	msg "Copy application settings"
	cp -rf ./conf/geany/colorschemes ~/.config/geany
	# 한글 폴더명을 영문으로 바꾸기
	cp -rf ./conf/user-dirs.dirs  ~/.config/
	mv -f ~/바탕화면 ~/Desktop
	mv -f ~/다운로드 ~/Downloads
	mv -f ~/템플릿 ~/Templates
	mv -f ~/공개 ~/Public
	mv -f ~/문서 ~/Documents
	mv -f ~/음악 ~/Music
	mv -f ~/사진 ~/Pictures
	mv -f ~/비디오 ~/Videos
	success "Complete"
}

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

media() {
	apt_add vlc audacious
	apt_add smplayer
}

dictionary() {
	apt_add goldendict
	# 다음 미니 영한사전 : http://engdic.daum.net/dicen/small_search.do?endic_kind=all&m=all&nil_profile=vsearch&nil_src=engdic&q=%GDWORD%
	# 다음 일반 영한사전: http://engdic.daum.net/dicen/search.do?endic_kind=all&m=all&nil_profile=vsearch&nil_src=engdic&q=%GDWORD%
}

gimp() {
	apt_add gimp
}

everpad() {
	repo_add ppa:nvbn-rm/ppa
	apt_add everpad
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

utilities() {
	apt_add p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller
	apt_add gnome-commander libgnomevfs2-extra krusader krename
	apt_add filezilla
	apt_add chromium-browser
	apt_add geany geany-common geany-plugins
	#apt_add terminator
	apt_add arandr
	apt_add clipit
	# apt_add gnome-do gnome-doc-utils gnome-do-plugins
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

atom() {
	repo_add ppa:webupd8team/atom
	apt_add atom
}

if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	disableUnnecessayErrorMessage;
	#languagePack;
	serviceManager;
	#uiTweakTools;
	cpuMemIndicator;
	#removeLens;
	#flash;
	everpad;
	torrent;
	media;
	dictionary;
	gimp;
	restrictedExtras;
	utilities;
	guiDevTools;
	run_all;
	powerlinefont;
	atom
	#freeUpSpace;
	msg "Complete."
	exit;
fi

if [ $1 == "copyconf" ]; then
	copyconf;
	exit;
fi

source ./install_run.sh
