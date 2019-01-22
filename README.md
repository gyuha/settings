settings
========

Gyuha's Linux Setting...

## Installation

Simply copying and pasting the following line into a terminal.

# Ubuntu 16.04

## 기본 서비스 패키지 설치

### 리눅스 사용자 설정
리눅스 터미널용 설정.
```bash
sudo apt install git
wget -O - https://raw.github.com/gyuha/settings/master/bootstrap.sh | bash
# 또는
wget -O - https://goo.gl/ti6IoK | bash

# Powerline 설정
wget -O - https://raw.github.com/gyuha/settings/master/bootstrap.sh | bash -s -- -p
```

-----
## vim 설정
개인 적인 vim 설정
```bash
curl https://raw.githubusercontent.com/gyuha/vim-start/master/vimrc > ~/.vimrc
```

## 참고
* https://vim-bootstrap.com/
* http://vim.spf13.com/

-----
## 참고
 * [Top Things To Do After Installing Ubuntu 18.04 Bionic Beaver To Make It Your Own](https://www.linuxuprising.com/2018/04/top-things-to-do-after-installing.html)
 * [Ubuntu 18.04 한글 입력기 UIM 설정하기](http://progtrend.blogspot.com/2018/06/ubuntu-1804-uim.html)


-----
## Tips
### 우분투 기본 터미널 바꾸기
```bash
sudo update-alternatives --config x-terminal-emulator
```
