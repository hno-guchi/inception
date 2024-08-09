#!/bin/bash

set -xe
mkdir -p /etc/nginx/ssl

if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=JP/ST=Tokyo/L=Shinjuku/O=42Tokyo/OU=Learner/CN=hnoguchi.42.fr"
fi

exec "$@"
