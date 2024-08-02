FROM debian:stable-slim

RUN apt-get update && apt-get install -y \
    nginx \
    php8.2-fpm \
    php8.2-mysql \
    php8.2-gd \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-curl \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# NginxとPHP-FPMの設定ファイルをコピー
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/sites-available/default

RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    mv wordpress /var/www/html/ && \
    chown -R www-data:www-data /var/www/html/ && \
    chmod -R 755 /var/www/html/

# ポート9000でリッスン
EXPOSE 9000

# NginxとPHP-FPMを起動
CMD service php8.2-fpm start && nginx -g 'daemon off;'
