FROM debian:stable-slim

RUN set -xe \
    && groupadd -r nginx \
    && useradd -r -g nginx nginx

RUN apt update \
	&& apt install -y nginx openssl curl \
    && rm -rf /var/lib/apt/lists/*

# nginxのアクセスログを標準出力にリダイレクト
# nginxのエラーログを標準エラー出力にリダイレクト
# 目的: ホストシステムがコンテナのログを簡単に取得できるようにする
# スクリプトの置き場所として作成
# カスタム設定やスクリプトを追加するための標準的な手法
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# 複数のスクリプトを実行するためのディレクトリを作成
# RUN mkdir /docker-entrypoint.d

# Nginxの設定ファイルをコピー
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# デフォルトのサイト設定をコピー
# COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 443
# EXPOSE 80 443

# STOPSIGINAL: コンテナが停止した時に送信するシグナルを指定
# SIGQUIT    : ダンプファイルを生成しデバッグ情報を提供する
STOPSIGNAL SIGQUIT

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
