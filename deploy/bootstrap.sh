#!/bin/bash

# package update
apt-get -y update
apt-get -y upgrade

# install php5
apt-get -y install php5

# install php5 mods
apt-get -y install php5-mcrypt
php5enmod mcrypt

# install git
apt-get -y install git

# install composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer