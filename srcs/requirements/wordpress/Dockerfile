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
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN set -xe \
    && wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && mkdir -p /var/www/html \
    && mv wordpress/* /var/www/html/ \
    && rm -rf wordpress latest.zip \
    && chown -R www-data:www-data /var/www/html

# www.confファイルの設定を変更
RUN sed -i 's|^listen = .*$|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

# 初期設定スクリプトを追加
COPY ./tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/www/html

EXPOSE 9000

HEALTHCHECK CMD pidof php-fpm8.2 || exit 1

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["php-fpm8.2", "-F"]
