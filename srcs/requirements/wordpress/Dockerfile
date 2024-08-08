FROM wordpress:fpm

EXPOSE 9000

# FROM debian:stable-slim

# RUN apt-get update && apt-get install -y \
#     php8.2-fpm \
#     php8.2-mysql \
#     php8.2-gd \
#     php8.2-mbstring \
#     php8.2-xml \
#     php8.2-curl \
#     wget git unzip \
#     && rm -rf /var/lib/apt/lists/*

# NginxとPHP-FPMの設定ファイルをコピー
# COPY nginx.conf /etc/nginx/nginx.conf
# COPY default.conf /etc/nginx/sites-available/default
# RUN wget https://wordpress.org/latest.zip
# RUN unzip latest.zip
# RUN mkdir -p /var/www/html
# RUN mv wordpress /var/www/html/
# RUN chown -R www-data:www-data /var/www/html

# RUN wget https://wordpress.org/latest.zip && \
#     unzip latest.zip && \
#     mv wordpress /var/www/html && \
#     chown -R www-data:www-data /var/www/html

# PHP-FPMの起動
# CMD ["php-fpm8.2", "-F"]
