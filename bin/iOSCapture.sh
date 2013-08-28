#!/bin/bash
# 아이폰 캡쳐 자동화
#
# 사용법
#
# $ iOSCapture.sh [저장 경로]
#
# 예) iOSCapture.sh ~/Desktop
#
#-------------------
# 어플리케이션 추가
#
# * 캡쳐 하기
# 	NSLog(@"screenshot mainmenu.png");
# * 한번만 캡쳐 하기
# 	NSLog(@"screenshot -once mainmenu.png");
# * 2초후에 캡쳐 하기
# 	NSLog(@"screenshot -delay 2.0 mainmenu.png");
#
# 참고 : 
# 	http://stackoverflow.com/questions/1360552/automate-screenshots-on-iphone-simulator/1579182#1579182

# 사용법에 대한 함수.
function usage()
{
	echo "`basename $0` [-h] [targetPath]"
	echo "    -h : 도움말"
	echo "    targetPath : 저장 할 경로"
}

while getopts :hr: optname ;do
	case $optname in
		h)
			usage; exit 1;;
	esac
done

cd /Applications
tail -f -n0 /var/log/system.log | iOSLogGrab.py $1
