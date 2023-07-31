FROM docker.io/php:fpm
COPY --chmod=755 ["build.sh", "install-php-extensions", "/"]
RUN ["/build.sh"]
