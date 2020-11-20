---
title: "DockerでOracle Databaseを立てる"
date: 2020-11-21T07:00:00+09:00
author: eiKatou
type: post
url: /20201121.html
archives:
  - 2020
tags:
  - IT技術
---

以前、Oracle 12cのDockerコンテナを立ち上げたことがあったけど、やり方をメモっていなかったので、再度 Oracle 19cでコンテナを立ち上げることにした。

ちょっとしたOracle DBの挙動確認に便利。

<!--more-->

# 参考したサイトと環境
以下のサイトを参考にした。
- [docker-images/OracleDatabase at master · oracle/docker-images](https://github.com/oracle/docker-images/tree/master/OracleDatabase)
- [Oracle Database 12c を macOS 上の Docker で構築する - Qiita](https://qiita.com/niwasawa/items/0834e77b0690a5c8501d)
- [DockerでOracle Databaseを使う - Qiita](https://qiita.com/gorilla0513/items/f22e8cce4e08da031abe)

環境は以下のとおり。

```shell
$ docker -v
Docker version 19.03.8, build afacb8b

$ sw_vers
ProductName:	Mac OS X
ProductVersion:	10.14.6
BuildVersion:	18G4032
```

インストールするOracleのバージョンは以下のもの。

- Oracle Database 19c (19.3.0) Enterprise Edition and Standard Edition 2

# Dockerイメージの作成
## ビルド準備
Gitリポジトリをクローン

```shell
git clone git@github.com:oracle/docker-images.git
```

[Oracle Technology Network](http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html)から「19.3 - Enterprise Edition Linux x86-64」のzipをダウンロード。

## ビルド

```shell
cd oracle_docker-images/OracleDatabase/SingleInstance
mv ~/Downloads/LINUX.X64_193000_db_home.zip dockerfiles/19.3.0
cd dockerfiles
./buildDockerImage.sh -v 19.3.0 -e -i
```

途中で容量が足りなくなって止まってしまったので、Dockerの設定画面からリソースを割り当て。再ビルドしてイメージができた。

```shell
$ docker images
REPOSITORY                    TAG                 IMAGE ID            CREATED             SIZE
oracle/database               19.3.0-ee           a45c3943066a        4 minutes ago       6.65GB
```

## Oracle起動

[Sample/Docker/Oracle at master · eiKatou/Sample](https://github.com/eiKatou/Sample/tree/master/Docker/Oracle)からdocker-compose.yamlを取得。そのディレクトリで作業する。

```shell
# Oracleのデータ出力用のディレクトリ作成
mkdir ./oradata
chmod 777 ./oradata

# Oracle起動
docker-compose up -d

# 起動できたかログで確認
# DATABASE IS READY TO USE! が確認できたら起動完了（15分ぐらいかかる）
docker logs -f oracle-19-ee
```

## Oracleに接続

[docker-images/README.md at master · oracle/docker-images](https://github.com/oracle/docker-images/blob/master/OracleDatabase/SingleInstance/README.md)にデフォルト値が書いてある。

- SID : ORCLCDB
- PDB : ORCLPDB1
- パスワード : password01(docker-compose.yamlに記載)

![oracle_connect](/uploads/2020/11/oracle_connect.jpg)

無事に接続できた！

## SQLの発行

```sql
select * from dba_users;
```

## Oracleが動いているDockerコンテナに接続
アラートログの確認もできる。

```shell
docker exec -it oracle-19-ee /bin/bash

# アラートログの確認
more /opt/oracle/diag/rdbms/orclcdb/ORCLCDB/trace/alert_ORCLCDB.log
```

## Dockerコンテナの終了

```shell
docker-compose down
```