#!/usr/bin/env bash

source ./install_common.sh

# only local run..
copyconf() {
	msg "Copy application settings"
	cp -rf ./conf/geany/colorschemes ~/.config/geany
	success "Complete"
}

koreanHome() {
	# 한글로 설치 후 기본 폴더명 변경.
	cp -rf ~/.settings/conf/user-dirs.dirs  ~/.config/
	mv -f ~/바탕화면 ~/Desktop
	mv -f ~/다운로드 ~/Downloads
	mv -f ~/템플릿 ~/Templates
	mv -f ~/공개 ~/Public
	mv -f ~/문서 ~/Documents
	mv -f ~/음악 ~/Music
	mv -f ~/사진 ~/Pictures
	mv -f ~/비디오 ~/Videos
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
	apt_add gnome-tweak-tool gnome-shell-extensions
	# Theme add
	apt_add adwaita-icon-theme-full arc-theme numix-gtk-theme numix-icon-theme
}

cpuMemIndicator() {
	repo_add ppa:indicator-multiload/stable-daily
	apt_add indicator-multiload
	success "Complete"
}


flash() {
	apt_add flashplugin-installer
}

torrent() {
	apt_add qbittorrent
}

media() {
	repo_add ppa:rvm/smplayer
	apt_add smplayer
	apt_add audacious comix okular
	apt_add ubuntu-restricted-extras
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


mysqlworkbench() {
	apt_add mysql-workbench
}


utilities() {
	apt_add p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller
	apt_add doublecmd-common
	apt_add libgnomevfs2-extra krusader krename
	apt_add geany geany-common geany-plugins
	#apt_add terminator
	apt_add arandr
	apt_add clipit
	#apt_add copyq
	# apt_add gnome-do gnome-doc-utils gnome-do-plugins
}

powerlinefont() {
	msg "Install powerline font"
	cd /tmp
	git clone https://github.com/powerline/fonts.git
	./fonts/install.sh
	rm -rf fonts
	wget https://github.com/eugeneching/consolas-powerline-vim/raw/master/CONSOLA-Powerline.ttf
	mv /tmp/CONSOLA-Powerline.ttf $HOME/.local/share/fonts
	fc-cache -f
	cd -
	success "Complete"
}


guiDevTools() {
	repo_add ppa:eugenesan/ppa
	apt_add gitg rapidsvn vim-gtk meld
	apt_add smartgit
	success "Complete"
}

atom() {
	repo_add ppa:webupd8team/atom
	apt_add atom
}

sublime_text3() {
	repo_add ppa:webupd8team/sublime-text-3
	apt_add sublime-text-installer
}

typora() {
	# Markdown editor
	repo_add 'deb https://typora.io/linux ./'
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
	apt_add typora 
}

if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	#disableUnnecessayErrorMessage;
	#languagePack;
	uiTweakTools;
	#cpuMemIndicator;
	#flash;
	everpad;
	torrent;
	media;
	dictionary;
	gimp;
	utilities;
	guiDevTools;
	run_all;
	#powerlinefont;
	#atom
	#sublime_text3
	#freeUpSpace;
	#typora
	msg "Complete."
	exit;
fi

if [ $1 == "copyconf" ]; then
	copyconf;
	exit;
fi

source ./install_run.sh
