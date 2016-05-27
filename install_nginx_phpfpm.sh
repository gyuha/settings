#!/usr/bin/env bash

source ./install_common.sh

# Nginx install
nginx() {
	repo_add "ppa:nginx/stable"
	apt_add nginx
}

# PHP-FPM install
phpfpm() {
	apt_add php7.0 php7.0-fpm php7.0-cli php7.0-common php7.0-curl php7.0-gd php7.0-gmp php7.0-json php7.0-ldap php7.0-mysql php7.0-odbc php7.0-pspell php7.0-readline php7.0-recode php7.0-sqlite3 php7.0-tidy php7.0-xml php7.0-xmlrpc php7.0-bcmath php7.0-bz2 php7.0-enchant php7.0-fpm php7.0-imap php7.0-interbase php7.0-intl php7.0-mbstring php7.0-mcrypt php7.0-phpdbg php7.0-soap php7.0-sybase php7.0-xsl php7.0-zip php-imagick php-redis php-apcu php-pear
}

restart_service() {
	service php7.0-fpm restart
	service nginx restart
}

copy_dev_conf() {
	msg "Copy development configure"
	msg "Nginx"
	copy_increase_number /etc/nginx/sites-available/default /tmp/nginx.conf
	cp -f ./conf/php7.0/development/nginx.conf /etc/nginx/sites-available/default

	msg "php-fpm"
	copy_increase_number /etc/php/7.0/fpm/php.ini /tmp/php.ini
	cp -f ./conf/php7.0/development/php.ini /etc/php/7.0/fpm/php.ini

	restart_service;
	success "Copy complete"
}

copy_product_conf() {
	msg "Copy product configure"

	msg "Nginx"
	copy_increase_number /etc/nginx/sites-available/default /tmp/nginx.conf
	cp -f ./conf/php7.0/product/nginx.conf /etc/nginx/sites-available/default

	msg "php-fpm"
	copy_increase_number /etc/php/7.0/fpm/php.ini /tmp/php.ini
	cp -f ./conf/php7.0/product/php.ini /etc/php/7.0/fpm/php.ini

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


source ./install_run.sh
