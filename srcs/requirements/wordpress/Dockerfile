FROM debian:oldstable-slim

RUN set -xe \
    && apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-gd \
    php7.4-mbstring \
    php7.4-xml \
    php7.4-curl \
    wget git unzip sendmail \
    && rm -rf /var/lib/apt/lists/*

RUN set -xe \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/latest.zip /latest.zip

# && wget https://wordpress.org/latest.zip
RUN set -xe \
    && unzip latest.zip \
    && mkdir -p /var/www/html \
    && mv wordpress/* /var/www/html/ \
    && rm -rf wordpress latest.zip \
    && chown -R www-data:www-data /var/www/html

# www.confファイルの設定を変更
RUN sed -i 's|^listen = .*$|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

# 初期設定スクリプトを追加
COPY ./tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# PIDファイルのディレクトリを作成し、適切な権限を設定
RUN mkdir -p /run/php && chown www-data:www-data /run/php

WORKDIR /var/www/html

EXPOSE 9000

HEALTHCHECK CMD pidof php-fpm7.4 || exit 1

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
# CMD ["php-fpm7.4", "-F"]
CMD ["php-fpm7.4", "--nodaemonize"]
