#!/bin/bash

set -euo pipefail

apt-get -y install git

/install-php-extensions bcmath apcu intl gd xdebug zip pgsql pdo_pgsql opcache memcached

rm /install-php-extensions /build.sh
