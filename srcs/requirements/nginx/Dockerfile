FROM debian:stable-slim

RUN set -x \
    && groupadd -r nginx \
    && useradd -r -g nginx nginx
RUN apt update && \
    apt install -y nginx openssl curl && \
    rm -rf /var/lib/apt/lists/*

# nginxのアクセスログを標準出力にリダイレクト
# nginxのエラーログを標準エラー出力にリダイレクト
# 目的: ホストシステムがコンテナのログを簡単に取得できるようにする
# スクリプトの置き場所として作成
# カスタム設定やスクリプトを追加するための標準的な手法
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && mkdir /docker-entrypoint.d

# SSL証明書とキーの作成
# RUN mkdir -p /etc/nginx/ssl && \
#     openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#     -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
#     -subj "/C=JP/ST=Tokyo/L=Shinjuku/O=42Tokyo/OU=Learner/CN=hnoguchi.42.fr"

# Nginxの設定ファイルをコピー
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# デフォルトのサイト設定をコピー
# COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# EXPOSE 80

# STOPSIGINAL: コンテナが停止した時に送信するシグナルを指定
# SIGQUIT    : ダンプファイルを生成しデバッグ情報を提供する
STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
