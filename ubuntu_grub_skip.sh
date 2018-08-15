#!/usr/bin/env bash
# 참고 : https://askubuntu.com/questions/1045656/grub-menu-still-displayed-with-18-04

if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

echo 'GRUB_DISABLE_OS_PROBER=true' >> /etc/default/grub
update-grub
