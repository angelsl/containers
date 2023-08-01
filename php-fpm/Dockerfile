FROM docker.io/php:fpm
COPY --chmod=755 ["build.sh", "install-php-extensions", "/"]
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
RUN ["/build.sh"]
