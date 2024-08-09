FROM debian:stable-slim

RUN set -xe \
    && apt-get update && apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-curl \
    wget git unzip \
    && rm -rf /var/lib/apt/lists/*

RUN set -xe \
    && wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && mkdir -p /var/www/html \
    && mv wordpress/* /var/www/html/ \
    && rm -rf wordpress latest.zip \
    && chown -R www-data:www-data /var/www/html

WORKDIR /var/www/html

EXPOSE 9000

HEALTHCHECK CMD curl --fail http://localhost:9000 || exit 1

CMD ["php-fpm8.2", "-F"]

# FROM wordpress:fpm

# EXPOSE 9000
