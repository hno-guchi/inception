#!/bin/bash

set -e

echo "Starting entrypoint script..."

# MariaDBの初期化
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo 'Initializing database...'
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo 'Database initialized.'
    echo 'Starting temporary MariaDB server...'
    mysqld_safe --skip-networking &
    pid="$!"

    mysql=( mysql --protocol=socket -uroot )

    for i in {30..0}; do
        if mysqladmin ping --silent; then
            break
        fi
        echo 'MariaDB init process in progress...'
        sleep 1
    done

    if [ "$i" = 0 ]; then
        echo >&2 'MariaDB init process failed.'
        exit 1
    fi

    echo "Creating user and database for WordPress..."
    "${mysql[@]}" <<EOSQL
SET @@SESSION.SQL_LOG_BIN=0;
CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION;
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL

    echo "Creating guest user without privileges..."
    "${mysql[@]}" <<EOSQL
CREATE USER '${GUEST_USER}'@'%' IDENTIFIED BY '${GUEST_USER_PASSWORD}';
EOSQL

    echo 'Removing temporary server...'
    if ! kill -s TERM "$pid" || ! wait "$pid"; then
        echo >&2 'MariaDB init process failed.'
        exit 1
    fi

    echo 'MariaDB init process done.'
fi

# MariaDBデーモンを起動
echo "Starting MariaDB server..."
exec mysqld --user=mysql --console
