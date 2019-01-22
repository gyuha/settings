#!/usr/bin/env bash

source ./install_common.sh

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


gui() {
	apt_add gnome-tweaks gnome-shell-extensions
	# Theme add
	apt_add adwaita-icon-theme-full arc-theme numix-gtk-theme numix-icon-theme
	apt_add chrome-gnome-shell
	apt_add gir1.2-gtop-2.0
	# simple tool to view and install deb files
	apt_add gdebi
	# graphical user interface for ufw
	apt_add gufw
	apt_add gnome-usage
}


flash() {
	apt_add flashplugin-installer
}

torrent() {
	apt_add qbittorrent
}

media() {
	apt_add smplayer
	apt_add vlc
	apt_add mpv
	apt_add audacious okular
	apt_add ubuntu-restricted-extras
}


dictionary() {
	apt_add goldendict
	# 다음 사전 : http://small.dic.daum.net/search.do?q=%GDWORD%
	# 다음 미니 영한사전 : http://engdic.daum.net/dicen/small_search.do?endic_kind=all&m=all&nil_profile=vsearch&nil_src=engdic&q=%GDWORD%
	# 다음 일반 영한사전: http://engdic.daum.net/dicen/search.do?endic_kind=all&m=all&nil_profile=vsearch&nil_src=engdic&q=%GDWORD%
	# 네이버 사전 :  http://endic.naver.com/search.nhn?sLn=kr&isOnlyViewEE=N&query=%GDWORD%
}

krita() {
	repo_add ppa:kritalime/ppa
	apt_add krita
}

graphic() {
	apt_add gimp pinta
	apt_add inkscape
}


mysqlworkbench() {
	apt_add mysql-workbench
}


utilities() {
	apt_add p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller
	apt_add doublecmd-common
	apt_add libgnomevfs2-extra krusader krename
	apt_add geany geany-common geany-plugins
	apt_add terminator
	apt_add arandr
	apt_add clipit

	# 한글 입력기
	# 참고 : ttp://la-nube.tistory.com/393
	apt_add uim
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

fonts() {
	apt_add fonts-nanum*
}

wine() {
	# 설치 후 현재 계정에서 아래와 같이 입력 함.
	# > WINEARCH=win32 WINEPREFIX=~/.wine wine wineboot
	apt_add wine-stable
	sudo apt install gnome-shell-extension-top-icons-plus
}


guiDevTools() {
	#repo_add ppa:eugenesan/ppa
	apt_add gitg vim-gtk3 meld
	#apt_add rapidsvn
	#apt_add smartgit
	success "Complete"
}


if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	#disableUnnecessayErrorMessage;
	gui;
	#flash;
	torrent;
	media;
	dictionary;
	graphic;
	utilities;
	guiDevTools;
	#mysqlworkbench;
	powerlinefont;
	fonts;
	#wine;
	run_all;
	msg "Complete.";
	exit;
fi

install_start;
