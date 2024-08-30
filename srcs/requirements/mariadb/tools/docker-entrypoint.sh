#!/bin/bash

set -e

echo "Starting entrypoint script..."

# MariaDBのデータディレクトリが初期化されていない場合
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    echo "Starting MariaDB temporarily..."
    mysqld_safe --user=mysql --skip-networking &
    pid="$!"

    echo "Waiting for MariaDB to start..."
    mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} --silent --wait=30 ping

    echo "Creating database and user..."
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
        DROP DATABASE IF EXISTS test;
        DELETE FROM mysql.user WHERE User='root' AND Host!='localhost';
        DELETE FROM mysql.user WHERE User='';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
EOSQL

    echo "Stopping MariaDB..."
	mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

    wait "$pid"

fi

# CMDで指定されたコマンドを使用してMariaDBを起動
echo "Executing command: $@"
exec "$@"
