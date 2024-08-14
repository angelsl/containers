#!/bin/bash

set -euo pipefail

apt-get update
apt-get -y install git locales
rm -rf /var/lib/apt/lists/*

cat <<EOF > /etc/locale.gen
en_US.UTF-8 UTF-8
en_SG.UTF-8 UTF-8
en_GB.UTF-8 UTF-8
EOF
locale-gen

/install-php-extensions bcmath apcu intl gd xdebug zip pgsql pdo_pgsql opcache memcached

rm /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
rm /install-php-extensions /build.sh
