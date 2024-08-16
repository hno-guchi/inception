#!/bin/bash
set -e

# create wp-config.php
if [ ! -f /var/www/html/wp-config.php ]; then
    wp core config --dbname="$WP_DB_NAME" --dbuser="$WP_DB_USER" --dbpass="$WP_DB_PASSWORD" --dbhost="$WP_DB_HOST" --path="/var/www/html" --allow-root
    wp core install --url="$WP_HOME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path="/var/www/html" --allow-root
    wp user create "$WP_SUB_USER" "$WP_SUB_EMAIL" --role=subscriber --user_pass="$WP_SUB_PASSWORD" --allow-root
fi

# PHP-FPMの起動
exec "$@"
