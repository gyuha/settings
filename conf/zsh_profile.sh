# GYUHA SETTINGS
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

PATH=$PATH:~/bin:~/.bin

set -o vi

alias tmux="tmux -2"
alias vi='vim'
alias of='/usr/bin/nautilus .' # 우분투에서 현재 폴더 탐색기로 열기
alias dgrep="grep --exclude-dir='.git' --exclude='*.swp'"
alias fd='fdfind'
alias python='python3'
alias pip='pip3'

alias tn='ts-node'

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='
--color=dark
--border
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'

function fzfp() {
	fzf --height 100% --color=bg+:24 --preview '[[ $(file --mime {}) =~ binary ]] &&
					 echo {} is a binary file ||
					 (highlight -O ansi -l {} ||
					  coderay {} ||
					  rougify {} ||
					  cat {}) 2> /dev/null | head -500'
}


# NVS
export NVS_HOME="$HOME/.nvs"
[ -s "$NVS_HOME/nvs.sh" ] && . "$NVS_HOME/nvs.sh"
nvs auto on

# for oh-my-zsh
