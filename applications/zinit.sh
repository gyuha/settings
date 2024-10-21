#!/bin/bash

# Update package list and install zsh
sudo apt update
sudo apt install -y zsh curl git

# Set zsh as default shell
chsh -s $(which zsh)

# Install Zinit
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# Configure .zshrc
cat <<EOT >> ~/.zshrc

# Load Zinit
source "\${HOME}/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( \${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# 문법 하이라이팅
zinit light zdharma-continuum/fast-syntax-highlighting
# 자동 제안
zinit light zsh-users/zsh-autosuggestions
# 명령어 완성
zinit light zsh-users/zsh-completions

zinit ice depth=1; zinit light romkatv/powerlevel10k

# ls 색상 활성화
zinit ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS

# ls와 관련된 별칭 설정
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# 기본 ls 색상 사용 (dircolors가 없는 경우를 대비)
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Load Powerlevel10k theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.settings/conf/zinit/p10k.zsh ]] || source ~/.settings/conf/zinit/p10k.zsh

EOT

# Print completion message
echo "Zinit installation complete!"
echo "Please restart your terminal or run 'source ~/.zshrc' to apply changes."
echo "After restarting, you may want to run 'p10k configure' to set up the Powerlevel10k theme."
