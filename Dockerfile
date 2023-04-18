FROM php:7.1-apache
RUN docker-php-ext-install pdo pdo_mysql
RUN apt-get update && apt-get upgrade -y
RUN if command -v a2enmod >/dev/null 2>&1; then \
        a2enmod rewrite headers \
    ;fi
COPY $PWD/php.ini /usr/local/etc/php
