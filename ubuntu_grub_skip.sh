#!/usr/bin/env bash

if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi

echo 'GRUB_DISABLE_OS_PROBER=true' >> /etc/default/grub
update-grub
