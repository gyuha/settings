#!/usr/bin/env bash

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
    ln -snf $BASEDIR/conf/tmux.conf $HOME/.tmux.conf
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


if [ ! -f $PROFILE ]
then
    PROFILE=$HOME/.bashrc
fi

BASHRC_SRC="# GYUHA SETTINGS
if [ -f $BASEDIR/conf/bash_profile ]; then
    . $BASEDIR/conf/bash_profile
fi
"

LINE=`grep -n "# GYUHA" $PROFILE |sed 's/\:.*$//g'`
LINE=`expr $LINE - 1`

# read the options
if grep -Fxq "# GYUHA SETTINGS" $PROFILE
then
    echo "Exist profile Settings"
    TMP_FILE="tmp"
    head -n $LINE $PROFILE > $TMP_FILE
    echo "$BASHRC_SRC" >> $TMP_FILE
    mv -f $TMP_FILE $PROFILE
else
    echo "$BASHRC_SRC" >> $PROFILE
fi

while [[ "$1" == -* ]]; do
    case $1 in
        -h)
            usage;
            exit;
            ;;
        -p)
            shift
            powerline_setting;
            ;;
    esac
    shift
done

echo -e "Type this \\n\\t# source $PROFILE"
