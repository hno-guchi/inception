#!/bin/bash
set -e

DB_NAME=${WORDPRESS_DB_NAME}
DB_USER=${WORDPRESS_DB_USER}
DB_PASSWORD=${WORDPRESS_DB_PASSWORD}
DB_HOST=${WORDPRESS_DB_HOST}
WP_HOME=${WORDPRESS_HOME}
WP_TITLE=${WORDPRESS_TITLE}
WP_ADMIN_USER=${WORDPRESS_ADMIN_USER}
WP_ADMIN_PASSWORD=${WORDPRESS_ADMIN_PASSWORD}
WP_ADMIN_EMAIL=${WORDPRESS_ADMIN_EMAIL}

# create wp-config.php
if [ ! -f /var/www/html/wp-config.php ]; then
    wp core config --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="$DB_HOST" --path="/var/www/html" --allow-root
    wp core install --url="$WP_HOME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path="/var/www/html" --allow-root
fi

# PHP-FPMの起動
exec "$@"
