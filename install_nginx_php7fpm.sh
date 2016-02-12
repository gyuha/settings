#!/usr/bin/env bash

source ./install_common.sh

# Nginx install
nginx() {
	#repo_add "ppa:nginx/stable"
	apt_add nginx
}

# PHP-FPM install
phpfpm() {
	repo_add "ppa:ondrej/php"
	apt_add git curl g++ build-essential php7.0-fpm php7.0-cli php7.0-common php7.0-json php7.0-opcache php7.0-mysql php7.0-odbc php7.0-sybase php7.0-phpdbg php7.0-dbg php7.0-gd php7.0-imap php7.0-ldap php7.0-pgsql php7.0-pspell php7.0-recode php7.0-snmp php7.0-tidy php7.0-dev php7.0-intl php7.0-gd php7.0-curl php7.0-bz2 php7.0-mcrypt php7.0-dev
}

redis_server() {
	apt_add redis-server
}

php7_redis() {
	# Install php 7 redis
	git clone https://github.com/phpredis/phpredis.git
	cd phpredis
	git checkout php7
	phpize
	./configure
	make && make install
	rm -rf phpredis

	cd /etc/php/mods-available
	echo "extension=redis.so" > redis.ini

	cd /etc/php/7.0/fpm/conf.d/
	ln -sf /etc/php/mods-available/redis.ini ./20-redis.ini

	cd /etc/php/7.0/cli/conf.d/
	ln -sf /etc/php/mods-available/redis.ini ./20-redis.ini
}

copyconf() {
	msg "Copy service conf"

	msg "Nginx"
	cp -f /etc/nginx/sites-available/default /tmp/nginx.conf
	cp -f ./conf/nginx/nginx.conf /etc/nginx/sites-available/default
	service nginx restart

	msg "php-fpm"
	cp -f /etc/php5/fpm/php.ini /tmp/php.dev.ini
	cp -f ./conf/php.dev.ini /etc/php5/fpm/php.ini
	service php5-fpm restart
	success "Copy complete"
}

if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	nginx;
	phpfpm;
	redis_server;
	run_all;
	php7_redis;
	exit;
fi

if [ $1 == "copyconf" ]; then
	copyconf;
	exit;
fi

source ./install_run.sh
