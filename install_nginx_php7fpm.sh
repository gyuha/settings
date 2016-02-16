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
	apt_add git curl g++ build-essential snmp php7.0-fpm php7.0-cli php7.0-common php7.0-json php7.0-opcache php7.0-mysql php7.0-odbc php7.0-sybase php7.0-phpdbg php7.0-dbg php7.0-gd php7.0-imap php7.0-ldap php7.0-pgsql php7.0-pspell php7.0-recode php7.0-snmp php7.0-tidy php7.0-dev php7.0-intl php7.0-gd php7.0-curl php7.0-bz2 php7.0-mcrypt php7.0-dev
}

redis_server() {
	apt_add redis-server
}

php7_mongodb() {
	apt-get install -y libcurl4-openssl-dev
	pecl install mongodb

	cd /etc/php/mods-available
	echo "extension=mongodb.so" > mongodb.ini

	cd /etc/php/7.0/fpm/conf.d/
	ln -sf /etc/php/mods-available/mongodb.ini ./20-mongodb.ini

	cd /etc/php/7.0/cli/conf.d/
	ln -sf /etc/php/mods-available/mongodb./20-mongodb.ini
}

php7_redis() {
	# Install php 7 redis
	git clone https://github.com/phpredis/phpredis.git
	cd phpredis
	git checkout php7
	phpize
	./configure
	make && make install
	cd ..
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
	copy_increase_number /etc/nginx/sites-available/default /tmp/nginx.conf
	cp -f ./conf/php7.0/nginx-site-default.conf /etc/nginx/sites-enabled/default

	msg "php-fpm"
	copy_increase_number /etc/php/7.0/fpm/php.ini /tmp/php.dev.ini
	cp -f ./conf/php7.0/php-fpm.ini /etc/php/7.0/fpm/php.ini

	service nginx restart
	service php7.0-fpm restart
	success "Copy complete"
}

if [ $PACKAGES == "all" ]; then
	msg "Install all packages."
	nginx;
	phpfpm;
	redis_server;
	run_all;
	php7_redis;
	php7_mongodb;
	copyconf;
	exit;
fi

if [ $1 == "copyconf" ]; then
	copyconf;
	exit;
fi

source ./install_run.sh
