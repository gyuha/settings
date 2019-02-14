#!/usr/bin/env bash

source ./install_common.sh

root_require;

# Nginx install
nginx() {
	repo_add "ppa:nginx/stable"
	apt_add nginx
}

# PHP-FPM install
phpfpm() {
	apt_add php-fpm php-cli php-common php-curl php-gd php-gmp php-json php-ldap php-mysql php-odbc php-pspell php-readline php-recode php-sqlite3 php-tidy php-xml php-xmlrpc php-bcmath php-bz2 php-enchant php-fpm php-imap php-interbase php-intl php-mbstring php-mcrypt php-phpdbg php-soap php-sybase php-xsl php-zip php-imagick php-redis php-apcu php-pear php-mongodb
}

restart_service() {
	service php-fpm restart
	service nginx restart
}

copy_dev_conf() {
	msg "Copy development configure"
	msg "Nginx"
	copy_increase_number /etc/nginx/sites-available/default /tmp/nginx.conf
	cp -f ./conf/php/development/nginx.conf /etc/nginx/sites-available/default

	msg "php-fpm"
	copy_increase_number /etc/php//fpm/php.ini /tmp/php.ini
	cp -f ./conf/php/development/php.ini /etc/php//fpm/php.ini

	restart_service;
	success "Copy complete"
}

copy_product_conf() {
	msg "Copy product configure"

	msg "Nginx"
	copy_increase_number /etc/nginx/sites-available/default /tmp/nginx.conf
	cp -f ./conf/php/product/nginx.conf /etc/nginx/sites-available/default

	msg "php-fpm"
	copy_increase_number /etc/php//fpm/php.ini /tmp/php.ini
	cp -f ./conf/php/product/php.ini /etc/php//fpm/php.ini

	restart_service;
	success "Copy complete"
}

if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	nginx;
	phpfpm;
	run_all;
	exit;
fi

if [ $1 == "dev" ]; then
	copy_dev_conf;
	exit;
elif [ $1 == "product" ]; then
	copy_product_conf;
	exit;
fi

source ./install_start.sh
