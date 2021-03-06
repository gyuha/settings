#!/usr/bin/env bash
# 우분투에서 한글키 매핑해 주기
# 참고 : http://progtrend.blogspot.com/2018/06/ubuntu-1804-uim.html

#오른쪽 Alt키의 기본 키 맵핑을 제거하고 'Hangul'키로 맵핑
xmodmap -e 'remove mod1 = Alt_R'
xmodmap -e 'keycode 108 = Hangul'

# 오른쪽 Ctrl키의 기본 키 맵핑을 제거하고 'Hangul_Hanja'키로 맵핑
xmodmap -e 'remove control = Control_R'
xmodmap -e 'keycode 105 = Hangul_Hanja'

#키 맵핑 저장
xmodmap -pke > ~/.Xmodmap
