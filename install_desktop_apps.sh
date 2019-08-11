#!/usr/bin/env bash

source ./lib/install_common.sh
root_require;

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
	apt install -y gnome-tweaks gnome-shell-extensions
	# Theme add
	add-apt-repository -y ppa:daniruiz/flat-remix
	apt update
	apt install -y flat-remix-gtk
	apt install -y adwaita-icon-theme-full arc-theme numix-gtk-theme numix-icon-theme
	# Gnome Extensions와 웹브라우저 연결을 위해서 필요.
	apt install -y chrome-gnome-shell
	apt install -y gir1.2-gtop-2.0
	# simple tool to view and install deb files
	apt install -y gdebi
	# graphical user interface for ufw
	apt install -y gufw
	apt install -y gnome-usage
}


flash() {
	apt install -y flashplugin-installer
}

torrent() {
	apt install -y qbittorrent
}

media() {
	# 비디오 플레이어
	apt install -y smplayer
	apt install -y vlc
	apt install -y mpv
	# 오디오 플레이어
	apt install -y audacious okular
	# Ubuntu Restricted Extras는 법적 또는 저작권상의 이유로 아직
	# 포함되지 않은 필수 소프트웨어를 사용자가 설치할 수있게 해주는
	# 컴퓨터 운영 체제 우분투 용 소프트웨어 패키지
	apt install -y ubuntu-restricted-extras
	# 배경 그림 바꾸기
	apt install -y variety
}


dictionary() {
	# 사전 프로그램
	apt install -y goldendict
	# 다음 사전 : http://small.dic.daum.net/search.do?q=%GDWORD%
	# 다음 미니 영한사전 : http://engdic.daum.net/dicen/small_search.do?endic_kind=all&m=all&nil_profile=vsearch&nil_src=engdic&q=%GDWORD%
	# 다음 일반 영한사전: http://engdic.daum.net/dicen/search.do?endic_kind=all&m=all&nil_profile=vsearch&nil_src=engdic&q=%GDWORD%
	# 네이버 사전 :  http://endic.naver.com/search.nhn?sLn=kr&isOnlyViewEE=N&query=%GDWORD%
}


graphic() {
	apt install -y gimp pinta
	apt install -y inkscape
}


mysqlworkbench() {
	apt install -y mysql-workbench
}


utilities() {
	apt install -y p7zip-rar p7zip-full unace unrar zip unzip sharutils rar uudeview mpack arj cabextract file-roller
	apt install -y doublecmd-common
	apt install -y libgnomevfs2-extra krusader krename
	apt install -y geany geany-common geany-plugins
	apt install -y terminator
	apt install -y arandr
	apt install -y copyq*

	# 한글 입력기
	# 참고 : ttp://la-nube.tistory.com/393
	# apt install -y uim
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
	apt install -y fonts-nanum*
}

wine() {
	# 설치 후 현재 계정에서 아래와 같이 입력 함.
	# > WINEARCH=win32 WINEPREFIX=~/.wine wine wineboot
	apt_add wine-stable
	apt install -y gnome-shell-extension-top-icons-plus
}


guiDevTools() {
	#repo_add ppa:eugenesan/ppa
	apt install -y gitg vim-gtk3 meld
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

source ./lib/install_start.sh
