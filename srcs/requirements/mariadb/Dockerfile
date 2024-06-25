# Base image
FROM debian:latest

# install package
RUN apt-get update && \
	apt-get install -y mariadb-server && \
	rm -rf /var/lib/apt/lists/*

# MariaDBをデフォルトで起動するエントリーポイントを設定
CMD ["mysqld"]
