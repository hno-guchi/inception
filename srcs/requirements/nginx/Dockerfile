FROM debian:stable-slim

RUN apt update && \
    apt install -y nginx openssl curl && \
    rm -rf /var/lib/apt/lists/*

# SSL証明書とキーの作成
# RUN mkdir -p /etc/nginx/ssl && \
#     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#     -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
#     -subj "/C=JP/ST=Tokyo/L=Shinjuku/O=42Tokyo/OU=Learner/CN=localhost"

# Nginxの設定ファイルをコピー
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# デフォルトのサイト設定をコピー
# COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# ポート80を公開
EXPOSE 80

# Nginxをフォアグラウンドで実行
CMD ["nginx", "-g", "daemon off;"]
