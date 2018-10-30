#!/usr/bin/env bash

if [ $UID -eq 0 ]; then
	echo Your root. Please run home user.
	exit 1;
fi

sudo apt install -y fonts-nanum*
sudo apt install -y wine-stable
sudo apt install -y gnome-shell-extension-top-icons-plus
WINEARCH=win32 WINEPREFIX=~/.wine wine wineboot
cd ~/Downloads/
wget https://raw.githubusercontent.com/winetricks/winetricks/master/src/winetricks
chmod +x winetricks
./winetricks riched30 gdiplus msxml6
sed -i 's/"MS Shell Dlg"="Tahoma"/"MS Shell Dlg"="NanumGothic"/' ~/.wine/system.reg
sed -i 's/"MS Shell Dlg"="Gulim"/"MS Shell Dlg"="NanumGothic"/' ~/.wine/system.reg
sed -i 's/"MS Shell Dlg 2"="Tahoma"/"MS Shell Dlg 2"="NanumGothic"/' ~/.wine/system.reg
wget http://app.pc.kakao.com/talk/win32/KakaoTalk_Setup.exe
wine ./KakaoTalk_Setup.exe
sed -i 's/.wine" wine-stable/.wine" LANG="ko_KR.UTF-8" wine-stable/' ~/.local/share/applications/wine/카카오톡.desktop
sed -i 's/.wine" wine-stable/.wine" LANG="ko_KR.UTF-8" wine-stable/' ~/.local/share/applications/wine/Programs/카카오톡/카카오톡.desktop
sed -i 's/.wine" wine-stable/.wine" LANG="ko_KR.UTF-8" wine-stable/' ~/.local/share/applications/wine/KakaoTalk.desktop
sed -i 's/.wine" wine-stable/.wine" LANG="ko_KR.UTF-8" wine-stable/' ~/.local/share/applications/wine/Programs/KakaoTalk/KakaoTalk.desktop
