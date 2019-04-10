#!/bin/bash

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
PROFILE=$HOME"/.zshrc"
BASHRC_SRC="# GYUHA SETTINGS
if [ -f $BASEDIR/conf/sh_profile ]; then
    . $BASEDIR/conf/sh_profile
fi
"

# 테마 설정하기
# sed -i "s/^ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"agnoster\"/" $PROFILE

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
