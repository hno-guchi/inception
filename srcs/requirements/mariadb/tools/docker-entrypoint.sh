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
    mysqladmin --silent --wait=30 ping

    echo "Creating database and user..."
    mysql <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
        FLUSH PRIVILEGES;
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
EOSQL

    echo "Stopping MariaDB..."
    mysqladmin shutdown

    wait "$pid"
fi

# その他の初期設定やカスタム設定をここに追加可能
# 例: タイムゾーンデータのインポートなど
# mysql_tzinfo_to_sql /usr/share/zoneinfo | mariadb -u root mysql

# CMDで指定されたコマンドを使用してMariaDBを起動
echo "Executing command: $@"
# exec mysqld --user=mysql --console
exec "$@"
