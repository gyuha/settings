if [ ! -n "$1" ] 
then
    echo 'Missed argument : hostname'
    exit 1
fi

if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root."
	exit 1
fi

hostname $1
chmod 777 /etc/hostname /etc/hosts
sed "s/template/$1/g" /etc/hosts > /home/user/hosts.out
rm /etc/hosts
mv /home/user/hosts.out /etc/hosts
echo "$1" > /etc/hostname
chmod 644 /etc/hostname /etc/hosts

#display new hostname
echo "Your new hostname is $1"

#Press a key to reboot
read -s -n 1 -p "Press any key to reboot"
sudo reboot
