# GYUHA SETTINGS

## Function to create alias if command exists
create_alias_if_exists() {
    local cmd=$1    # Original command
    local alias=$2  # Alias to create

    if command -v "$cmd" &> /dev/null; then
        alias "$alias"="$cmd"
    fi
}

## 기본 ls 색상 사용 (dircolors가 없는 경우를 대비)
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

PATH=$PATH:~/bin:~/.bin:~/.local/bin:~/.settings/bin:/snap/bin

set -o vi

alias tmux="tmux -2"
alias vi='nvim'
alias of='/usr/bin/nautilus .' # 우분투에서 현재 폴더 탐색기로 열기
alias dgrep="grep --exclude-dir='.git' --exclude='*.swp'"

## ls와 관련된 별칭 설정
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lt='tree -d'

## AI Cli
alias cl='claude'
alias cld='claude --dangerously-skip-permissions'

alias ge='gemini'
alias gey='gemini -y'
alias cx='codex'
alias cxd='codex --dangerously-bypass-approvals-and-sandbox'

alias tm='task-master'
alias taskmaster='task-master'

# create_alias_if_exists "python3" "python"
# create_alias_if_exists "pip3" "pip"
create_alias_if_exists "fdfind" "fd"

create_alias_if_exists "ts-node" "ts"
create_alias_if_exists "pnpm" "pn"

# Basic ZSH configurations
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

## fzf 설정
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

# Tabby ssh config
precmd () { echo -n "\x1b]1337;CurrentDir=$(pwd)\x07" }
