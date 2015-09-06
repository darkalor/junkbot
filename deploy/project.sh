#!/bin/bash

# composer update
cd /vagrant
composer global require "fxp/composer-asset-plugin:1.0.0"
# --prefer-dist to speed up install
composer install --prefer-dist