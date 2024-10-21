#!/usr/bin/env bash
# Vim setting base : http://vim.spf13.com/

echo "Copy Settings"
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
echo $BASEDIR
ln -snf $BASEDIR/bin $HOME/.bin

rm -rf $HOME/.tmux.conf

PROFILE=$HOME"/.bashrc"
POWERLINE="$BASEDIR/conf/powerline"

function usage()
{
    echo "
Gyuha's linux setting install
Usage: `basename $0` [-p]

    -p : Use powerline
    -h : help
    "
}

function powerline_setting()
{
    echo "Use powerline"
    # Tmux 세팅
    sed -i "s/\t\"wan_ip/\t\#\"wan_ip/" $BASEDIR/bin/tmux-powerline/themes/default.sh
    sed -i "s/\t\"mailcount/\t\#\"mailcount/" $BASEDIR/bin/tmux-powerline/themes/default.sh
    sed -i "s/\t\"now_playing/\t\#\"now_playing/" $BASEDIR/bin/tmux-powerline/themes/default.sh
    sed -i "s/\t\"load/\t\#\"load/" $BASEDIR/bin/tmux-powerline/themes/default.sh
    sed -i "s/\t\"battery/\t\#\"battery/" $BASEDIR/bin/tmux-powerline/themes/default.sh
    sed -i "s/\t\"weather/\t\#\"weather/" $BASEDIR/bin/tmux-powerline/themes/default.sh
    # vim
    #   sed -i "s/\"let g:Powerline_symbols/let g:Powerline_symbols/" $HOME/.vimrc
    cat $POWERLINE >> $PROFILE
}

BASHRC_SRC="# GYUHA SETTINGS
if [ -f $BASEDIR/conf/sh_profile.sh ]; then
    . $BASEDIR/conf/sh_profile.sh
    . $BASEDIR/conf/bash_ps1.sh
    . $BASEDIR/conf/inputrc.sh
fi
# GYUHA SETTINGS END
"

while [[ "$1" == -* ]]; do
    case $1 in
        -h)
            usage;
            exit;
            ;;
        -p)
            shift
BASHRC_SRC=$BASHRC_SRC"
if [ -f $BASEDIR/conf/bash_powerline.sh ]; then
    . $BASEDIR/conf/bash_powerline.sh
fi
"
            powerline_setting;
            ;;
        -c)
            shift
BASHRC_SRC=$BASHRC_SRC"
if [ -f $BASEDIR/conf/bash_colorline.sh ]; then
    . $BASEDIR/conf/bash_colorline.sh
fi
"
            ;;
    esac
    shift
done

echo $BASHRC_SRC

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
