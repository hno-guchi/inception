FROM debian:oldstable-slim

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

# RUN mkdir /docker-entrypoint-initdb.d
# COPY ./tools/init.sql /docker-entrypoint-initdb.d/
# COPY ./tools/create_db.sql /docker-entrypoint-initdb.d/

VOLUME /var/lib/mysql

COPY ./tools/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mariadbd"]
