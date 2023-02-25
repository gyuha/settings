#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

ZSH_CUSTOM=~/.oh-my-zsh/custom

# 플러그인 설치
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions --depth=1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting --depth=1
git clone https://github.com/lukechilds/zsh-better-npm-completion ~/.oh-my-zsh/custom/plugins/zsh-better-npm-completion --depth=1


PROFILE=$HOME"/.zshrc"


SEARCH_STR="# GYUHA SETTINGS"
BASHRC_SRC="
#######################################################
# GYUHA SETTINGS

export ZSH="$HOME/.oh-my-zsh"


if [ -f $HOME/.settings/conf/zsh_profile.sh ]; then
    . $HOME/.settings/conf/zsh_profile.sh
fi


plugins=(
  git
  autojump
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-better-npm-completion
)

ZSH_THEME="bira"

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $ZSH/oh-my-zsh.sh
"

echo "$BASHRC_SRC" > "$PROFILE"

## 개인 설정 적용하기
#if grep -q -F "$SEARCH_STR" "$PROFILE"; then
    #echo "BASHRC_SRC is already present in $PROFILE"
#else
    ## Append BASHRC_SRC to the zshrc file
    #echo "$BASHRC_SRC" >> "$PROFILE"
    #echo "BASHRC_SRC has been added to $PROFILE"
#fi

echo -e "Type this \\n\\t# source $PROFILE"
