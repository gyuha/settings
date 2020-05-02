#!/bin/bash

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
PROFILE=$HOME"/.zshrc"
BASHRC_SRC="# GYUHA SETTINGS
if [ -f $BASEDIR/conf/sh_profile ]; then
    . $BASEDIR/conf/sh_profile
fi
"

# bullet-train 테마 받기
wget http://raw.github.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme && mv bullet-train.zsh-theme $ZSH_CUSTOM/themes/

# 테마 설정하기
sed -i "s/^ZSH_THEME=\".*\"$/ZSH_THEME=\"bullet-train\"/" $PROFILE

# 플러그인 설치
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions --depth=1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting --depth=1
git clone https://github.com/lukechilds/zsh-better-npm-completion ~/.oh-my-zsh/custom/plugins/zsh-better-npm-completion --depth=1

# 플로그인 붙여 넣기
PLUGIN="
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-better-npm-completion
)
"
echo "$PLUGIN" >> $PROFILE


# 개인 설정 적용하기
LINE=`grep -n "# GYUHA" $PROFILE |sed 's/\:.*$//g'`

if [ "$LINE" == "" ]
then
    echo "$BASHRC_SRC" >> $PROFILE
else
    LINE=`expr $LINE - 1`
    echo "Exist profile settings"
    TMP_FILE="tmp"
    head -n $LINE $PROFILE > $TMP_FILE
    echo "$BASHRC_SRC" >> $TMP_FILE
    mv -f $TMP_FILE $PROFILE
fi

echo -e "Type this \\n\\t# source $PROFILE"
