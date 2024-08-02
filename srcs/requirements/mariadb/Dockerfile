FROM debian:stable-slim

RUN apt update && apt install -y mariadb-server
# mysqld.sockのディレクトリを作成し、適切なパーミッションを設定
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# docker-entrypoint.shをコンテナにコピーし、実行可能にする
COPY ./tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# ENTRYPOINTディレクティブでスクリプトを指定
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["mysqld"]
