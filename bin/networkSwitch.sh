#!/usr/bin/env bash

if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

MAGENTA='\e[0;35m'
RED='\e[0;31m'
END_COLOR='\e[0m'

function usage()
{
	echo -e "
	Network interface switcher..
	Usage: `basename $0` [dhcp OR other]
	* dhcp
	Example > $MAGENTA`basename $0` dhcp [INTERFACE]$END_COLOR
	* other
	`basename $0` [INTERFACE] [ip] [gateway]
	Example > $MAGENTA`basename $0` eth0 192.168.0.100 192.168.0.1$END_COLOR
	-h : help
	"
}

function networkRestart()
{
	echo -e "$RED Restart Networking $END_COLOR"
	service networking restart
}

DHCP="
auto lo
iface lo inet loopback

auto INTERFACE
iface INTERFACE inet dhcp
"

STATIC="
auto lo
iface lo inet loopback

auto $1
	iface $1 inet static
	address $2
	netmask 255.255.255.0
	gateway $3
	dns-nameservers 168.126.63.1 8.8.8.8
"

case "$1" in
	"-h")
		usage;
		exit 0;
		;;
	"dhcp")
		if [ -z "$2" ]; then
			INTERFACE="eth0"
		else
			INTERFACE=$2
		fi
		DHCP=${DHCP//INTERFACE/$INTERFACE}
		echo -e "$DHCP" > /etc/network/interfaces
		networkRestart;
		exit 0;
		;;
esac

echo -e "$STATIC" > /etc/network/interfaces
networkRestart;
