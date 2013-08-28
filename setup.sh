#!/bin/bash
# Vim setting base : http://vim.spf13.com/

echo "Copy Settings"
LPATH=`pwd`
ln -snf $LPATH/bin $HOME/.bin
ln -snf $LPATH/vim $HOME/.vim
ln -snf $LPATH/vimrc.bundles $HOME/.vimrc.bundles
ln -snf $LPATH/vimrc.bundles.local $HOME/.vimrc.bundles.local
ln -snf $LPATH/vimrc $HOME/.vimrc
ln -snf $LPATH/vimrc.local $HOME/.vimrc.local

rm -rf $HOME/.tmux.conf

PROFILE=$HOME"/.bashrc"
ADD_PROFILE="./bashrc"
POWERLINE="./powerline"

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
	ln -snf $LPATH/tmux.conf $HOME/.tmux.conf
	# vim
	#sed -i "s/\"let g:Powerline_symbols/let g:Powerline_symbols/" $HOME/.vimrc
	# shell 세팅.
	cd $HOME/.bin/powerline-shell
	$HOME/.bin/powerline-shell/install.py
	cd -
	cat $POWERLINE >> $PROFILE
}


if [ ! -f $PROFILE ]
then
PROFILE=$HOME/.bashrc
fi

LINE=`grep -n "# GYUHA" $PROFILE |sed 's/\:.*$//g'`
LINE=`expr $LINE - 1`

# read the options
if grep -Fxq "# GYUHA SETTINGS" $PROFILE
then
	echo "Exist profile Settings"
	TMP_FILE="tmp"
	head -n $LINE $PROFILE > $TMP_FILE
	cat $ADD_PROFILE >> $TMP_FILE
	mv -f $TMP_FILE $PROFILE
else
	cat $ADD_PROFILE >> $PROFILE
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
