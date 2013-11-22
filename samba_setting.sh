#!/bin/bash

if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

CONF_FILE="/etc/samba/smb.conf"
CONF_BACKUP_FILE="/tmp/smb.origin.conf"

function usage()
{
    echo "
Samba Settings
Usage: `basename $0` [-i] [-p] [-h] [-u] [-r]

	-i : Install samba service
    -p : Add samba share path
    -u : Add samba user
    -h : help
	-r : Restart samba service
    "
}

function install()
{
	apt-get install -y samba
	cp -f $CONF_FILE $CONF_BACKUP_FILE
	sed -i 's/#  security = user/   security = user/' $CONF_FILE
}

function addSmbUser()
{
	echo "Add $1 User"
	addgroup smbusers
	smbpasswd -a $1
	usermod -a -G smbusers $1
}

function addSharePath()
{
	SHARE_NAME=`basename $1`

	if grep -Fxq $SHARE_NAME $CONF_FILE
	then
		echo "Exist $SHARE_NAME Share"
		return 1
	fi

	echo "
[$SHARE_NAME]
comment = Shared Path
path = $1
writable = yes
create mask = 0775
directory mode = 0775
force group = smbusers
"	>> $CONF_FILE

}

# check for empty search
if [[ "" = "$@" ]]; then
	echo "(no search term. \``basename $0` -h\` for usage)"
	exit 1
fi

# read the options
while [[ "$1" == -* ]]; do
    case $1 in
        -h)
            usage;
            exit;
            ;;
        -i)
			shift
            install
            ;;
        -p)
            shift
			addSharePath $1
            ;;
		-r)
			shift
			service smbd restart
			;;
		-u)
			shift
			addSmbUser $1
			;;
    esac
    shift
done
