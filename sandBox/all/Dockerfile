FROM debian:latest

RUN apt update
RUN apt install -y vim wget unzip
RUN apt install -y nginx
RUN apt install -y php8.2-fpm php8.2-mysqli php8.2-gd php8.2-curl php8.2-xml php8.2-mbstring php8.2-zip
RUN apt install -y mariadb-server
RUN service nginx start

RUN wget https://wordpress.org/latest.zip
RUN unzip latest.zip
RUN mv wordpress /var/www/html/
