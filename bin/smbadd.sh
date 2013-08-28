#!/bin/sh
#smbadd.sh
echo "Please enter the new system and samaba user's name:"
	read name
echo "Please enter password for $name:"
	read pass
echo "Making $name a system  and samba user"
echo $pass > useradd -p $name
echo $pass > smbpasswd -a -s  $name
