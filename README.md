settings
========

Gyuha's Linux Setting...

## Installation

Simply copying and pasting the following line into a terminal.

# Ubuntu 24.04

## 기본 서비스 패키지 설치

### 리눅스 사용자 설정
리눅스 터미널용 설정.
```bash
sudo apt install git curl
wget -O - https://raw.github.com/gyuha/settings/master/bootstrap.sh | bash
# 또는
wget -O - https://goo.gl/ti6IoK | bash

# Powerline 설정
wget -O - https://raw.github.com/gyuha/settings/master/bootstrap.sh | bash -s -- -p
```

### zsh 설치
```bash
cd ~/.settings/applications
./zinit.sh
```

### fzf 설치
```bash
cd ~/.settings/applications
./fzf.sh
```
#### fzf key binding
- `ctrl + t` : 파일 찾기
- `ctrl + r` : 커맨드상에서 입력했던 history search
- `alt + c` : 경로 이동 용

-----
## vim 설정
개인 적인 vim 설정
```bash
wget -O - https://raw.githubusercontent.com/gyuha/vim-start/master/vimrc > ~/.vimrc
```

## neovim 설정
개인 적인 vim 설정
```bash
ln ~/.settings/conf/nvim ~/.config/nvim
```

## 참고
* https://vim-bootstrap.com/
* http://vim.spf13.com/


-----
## Tips
### 우분투 기본 터미널 바꾸기
```bash
sudo update-alternatives --config x-terminal-emulator
```
