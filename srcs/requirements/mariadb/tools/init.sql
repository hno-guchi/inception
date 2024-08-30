-- root ユーザーのパスワードを再設定
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- テストデータベースを削除
DROP DATABASE IF EXISTS test;

-- リモートからの root ログインを禁止
DELETE FROM mysql.user WHERE User='root' AND Host!='localhost';

-- 不要なユーザーを削除
DELETE FROM mysql.user WHERE User='';

-- root ユーザーのパスワード認証方式を変更
ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'your_password';

-- 権限をリロード
FLUSH PRIVILEGES;

CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
FLUSH PRIVILEGES;
