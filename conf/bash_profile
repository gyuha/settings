# GYUHA SETTINGS
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

export SVN_EDITOR="vim --noplugin"

PATH=$PATH:~/bin:~/.bin

set -o vi

# shell prompt
#export PS1='\[\033[0;35m\]\h\[\033[0;33m\] \w\[\033[00m\]$ '
# 쉘 프롬프트 색상 선택이 가능 할 경우
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	export PS1='[\[\033[0;35m\]\u@\h\[\033[0;34m\]:\W\[\033[00m\]]$ '
else
	export PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi

#ryan 256 color support
#if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#	export TERM='xterm-256color'
#else
#	export TERM='xterm-color'
#fi

export TERM='screen-256color'
export EDITOR=vim

alias tmux="tmux -2"
alias vi='vim'
alias of='/usr/bin/nautilus .' # 우분투에서 현재 폴더 탐색기로 열기
alias devgrep="grep --exclude-dir='.svn' --exclude='*.swp'"
