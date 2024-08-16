FROM debian:stable-slim

RUN set -ex \
    && groupadd -r mysql \
    && useradd -r -g mysql mysql --home-dir /var/lib/mysql

RUN set -ex \
    && apt update && apt install -y mariadb-server \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /var/lib/mysql \
    && mkdir -p /var/lib/mysql /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /run/mysqld \
    && chmod 1777 /var/lib/mysql /run/mysqld

VOLUME /var/lib/mysql

# USER mysql

COPY ./tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mariadbd"]

# FROM mariadb:11.4
