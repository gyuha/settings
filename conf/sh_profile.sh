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
# alias python='python3'
# alias pip='pip3'

alias tn='ts-node'

export FZF_DEFAULT_OPTS='
--color=dark
--border
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'


# 파일 검색 및 미리보기
function fzfp() {
	fzf --height 100% --color=bg+:24 --preview '[[ $(file --mime {}) =~ binary ]] &&
					 echo {} is a binary file ||
					 (highlight -O ansi -l {} ||
					  coderay {} ||
					  rougify {} ||
					  cat {}) 2> /dev/null | head -500'
}

# vim을 이용한 replase
function vsed() {
	search=$1
	replace=$2
	shift
	shift
	vim -c "bufdo! set eventignore-=Syntax| %s/
	$search/$replace/gce" $*
}

# Removing Temporary Python Files
alias pyclean='find . \
	\( -type f -name "*.py[co]" -o -type d -name
	"__pycache__" \) -delete &&
		echo "Removed pycs and __pycache__"'

# Listing and Filtering Processes
alias pg='ps aux | grep -v grep | grep $1'

# Unix Timestamp
alias timestamp='date "+%s"'
