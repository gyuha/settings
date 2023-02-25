#!/usr/bin/zsh
## 윈도우 wsl2 에서는 더럽게 느리다..

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
	ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

CONF="
source \"${ZDOTDIR:-$HOME}/.zprezto/init.zsh\"
"

echo $CONF >> ~/.zshrc
