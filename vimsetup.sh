#!/bin/bash
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
echo $BASEDIR

ln -snf $BASEDIR/vimrc.local $HOME/.vimrc.local
ln -snf $BASEDIR/vimrc.bundles.local $HOME/.vimrc.bundles.local

function usage()
{
	echo "
Gyuha's vim setting
Usage: `basename $0` [-p]

-h : help
-u : update
"
}

install() {
    echo "Install spf13-vim."
    cd $HOME
    curl http://j.mp/spf13-vim3 -L -o - | sh
}

update() {
    cd $HOME/to/spf13-vim/
    git pull
    vim +BundleInstall! +BundleClean +q
}

# 파라메터가 없으면.설치
[ $# -lt 1 ] && install && exit 1

while [[ "$1" == -* ]]; do
    case $1 in
        -h)
            usage;
            exit;
            ;;
        -p)
            shift
			update;
            ;;
    esac
    shift
done
