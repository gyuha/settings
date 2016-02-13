#!/usr/bin/env bash

source ./install_common.sh

# Nginx install
nginx() {
	repo_add "ppa:nginx/stable"
	apt_add nginx
}

# PHP-FPM install
phpfpm() {
	apt_add php5-fpm php5 php-apc php-pear php5-cli php5-common php5-curl php5-dev php5-fpm php5-gd php5-gmp php5-imap php5-ldap php5-mcrypt php5-memcache php5-memcached php5-mysql php5-odbc php5-pspell php5-recode php5-sqlite php5-sybase php5-tidy php5-xmlrpc php5-xsl php5-mongo php5-xmlrpc php5-json php5-imagick php5-redis
}

copyconf() {
	msg "Copy service conf"

	msg "Nginx"
	cp -f /etc/nginx/sites-available/default /tmp/nginx.conf
	cp -f ./conf/nginx.conf /etc/nginx/sites-available/default

	msg "php-fpm"
	cp -f /etc/php5/fpm/php.ini /tmp/php.dev.ini
	cp -f ./conf/php.dev.ini /etc/php5/fpm/php.ini

	service php5-fpm restart
	service nginx restart
	success "Copy complete"
}

if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	nginx;
	phpfpm;
	run_all;
	exit;
fi

if [ $1 == "copyconf" ]; then
	copyconf;
	exit;
fi

source ./install_run.sh
