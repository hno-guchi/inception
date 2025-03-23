# Inception

42のカリキュラムにある課題。Docker およびコンテナオーケストレーションの理解を深めました。このプロジェクトでは、**Docker Compose** を使用して複数のコンテナを構成し、仮想化された環境を実装します。

## 目標

- **Docker** と **Docker Compose** を使用して、複数のサービスをコンテナ化
- 各サービスを **独立したコンテナ** として管理し、相互に通信できるようにする
- データの永続化を考慮し、**ボリューム（Volumes）** を利用
- **セキュリティ** を確保しつつ、適切な設定を行う
- **Nginx** をリバースプロキシとして設定し、ロードバランシングを行う

## 構成

Inception では、以下のコンテナを作成・管理します。

| コンテナ名 | 説明 |
|------------|---------------------------|
| **Nginx**  | リバースプロキシとして動作し、HTTPS 対応を実装 |
| **WordPress** | PHP + WordPress を動作させる CMS コンテナ |
| **MariaDB**  | データベースコンテナ（WordPress 用） |

## インストール & 実行方法

### 必要環境
- **Docker** (20.10 以上)
- **Docker Compose** (1.29 以上)
- **Make** (オプション)

### セットアップ

1. **リポジトリをクローン**
   ```sh
   git clone https://github.com/~
   cd inception

2. **./srcs/.envを作成し環境変数を設定**
   ```
   WP_DB_NAME=[env value]
   WP_DB_USER=[env value]
   WP_DB_PASSWORD=[env value]
   WP_DB_ROOT_PASSWORD=[env value]
   WP_DB_GUEST_USER=[env value]
   WP_DB_GUEST_PASSWORD=[env value]
   WP_DB_HOST=[env value]
   WP_HOME=[env value]
   WP_TITLE=[env value]
   WP_ADMIN_USER=[env value]
   WP_ADMIN_PASSWORD=[env value]
   WP_ADMIN_EMAIL=[env value]
   WP_SUB_USER=[env value]
   WP_SUB_PASSWORD=[env value]
   WP_SUB_EMAIL=[env value]

3. **実行**
   ```sh
   make


