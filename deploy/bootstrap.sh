#!/bin/bash

# package update
apt-get -y update
apt-get -y upgrade

# install apache2
apt-get -y install apache2

# install php5
apt-get -y install php5

# install php5 mods
apt-get -y install php5-mcrypt
php5enmod mcrypt

# enable mod_rewrite
a2enmod rewrite

# install git
apt-get -y install git

# install composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# install xdebug
apt-get install php5-xdebug
XDEBUG_SO="$(find /usr/lib -name 'xdebug.so')"

# configure xdebug
grep -w 'xdebug.remote_enable=1' /etc/php5/apache2/conf.d/20-xdebug.ini &> /dev/null

if [ $? == 1 ]; then
    sed -i 's/.*//g' /etc/php5/apache2/conf.d/20-xdebug.ini

    echo "zend_extension=\"${XDEBUG_SO}\""       >> /etc/php5/apache2/conf.d/20-xdebug.ini
    echo "xdebug.remote_autostart=0"             >> /etc/php5/apache2/conf.d/20-xdebug.ini
    echo "xdebug.remote_enable=1"                >> /etc/php5/apache2/conf.d/20-xdebug.ini
    echo "xdebug.remote_handler=\"dbgp\""        >> /etc/php5/apache2/conf.d/20-xdebug.ini
    echo "xdebug.remote_host=\"${XDEBUG_HOST}\"" >> /etc/php5/apache2/conf.d/20-xdebug.ini
    echo "xdebug.remote_port=${XDEBUG_PORT}"     >> /etc/php5/apache2/conf.d/20-xdebug.ini
    echo "xdebug.remote_mode=req"                >> /etc/php5/apache2/conf.d/20-xdebug.ini
    echo "xdebug.idekey=\"${XDEBUG_IDEKEY}\""    >> /etc/php5/apache2/conf.d/20-xdebug.ini
    echo "xdebug.remote_connect_back=1"          >> /etc/php5/apache2/conf.d/20-xdebug.ini
    echo "xdebug.profiler_enable=0"              >> /etc/php5/apache2/conf.d/20-xdebug.ini
fi

# restart apache
service apache2 restart