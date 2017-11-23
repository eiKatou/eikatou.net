---
title: "AWS Cognitoを使ってサーバレスアプリケーションに認証をつける"
date: 2017-11-24T06:12:14+09:00
author: eiKatou
type: post
url: /20171124.html
archives:
  - 2017
tags:
  - AWS 
  - Dev
---

![AWS Logo](/uploads/logo/aws.jpg)

[前回](/20171119.html)のアプリケーションに、AWS Cognitoを使って認証機能をつけた。

認証はメールアドレスとパスワードで行う。初めにサインアップを行う。メールアドレスとパスワードを入力して登録すると、アクティベーションコードが書かれたメールが届く。アクティベーションコードを入力すると登録が完了する。その後、ログインが可能となる。

また、Cognitoでログインしたユーザのみが、自分のデータにアクセスできるようにする。データアクセスはAPI Gatewayを使わずにS3のデータを直接取得している。

<!--more-->

# AWS Cognitoの設定
Cognitoの設定を行う。ユーザプールとフェデレーテッドアイデンティティの2つの設定を行う必要がある。

## ユーザプールの設定
ユーザプールの設定は、画面に表示される内容を選択していくだけ。

![AWS Cognito](/uploads/2017/11/cognito_1.jpeg)

![AWS Cognito](/uploads/2017/11/cognito_2.jpeg)

## フェデレーテッドアイデンティティの設定
ロールを作成することになるので、IAMの権限が必要となるので要注意。

![AWS Cognito](/uploads/2017/11/cognito_3.jpeg)

![AWS Cognito](/uploads/2017/11/cognito_4.jpeg)

![AWS Cognito](/uploads/2017/11/cognito_5.jpeg)

![AWS Cognito](/uploads/2017/11/cognito_6.jpeg)

# AWS S3の設定
AWS S3のデータは、静的ホスティングをしていると、誰でも閲覧することができる。ユーザに自分だけのデータを見せるには権限設定を行う必要がある。

[IAM ロール - Amazon Cognito](http://docs.aws.amazon.com/ja_jp/cognito/latest/developerguide/iam-roles.html)を参考にバケットポリシーの設定を行った。

# 認証周りを実装
[aws/amazon-cognito-identity-js](https://github.com/aws/amazon-cognito-identity-js)を使って、認証周りを実装していく。README通りに実装して動いたので、簡単だった。

vuexを使っているので、/store/modules/auth.jsとして実装を行なった。全体のソースは[eiKatou/Bango_frontend](https://github.com/eiKatou/Bango_frontend)を参照してほしい。

<script src="https://gist.github.com/eiKatou/f7f04f075374544db94a22467bd6cec9.js"></script>

<script src="https://gist.github.com/eiKatou/25af74b2e1f62fb035106dc0d11264f2.js"></script>

# 認証を使用してS3のデータを取得
AWS.config.credentialsにJWT Tokenを設定して、S3のオブジェクトを取得する。そのため、JWT Tokenは保持しておかないといけない。

<script src="https://gist.github.com/eiKatou/530ae34431f36aeb99670ba4fa62938d.js"></script>

# 悩んだところ
## S3のCORSの設定
以下のエラーとなった。

> Failed to load resource: Preflight response is not successful

これは、S3のCORSの設定が出来ていないことが原因だった。

## identityPoolIdの指定
以下のエラーとなった。

> ValidationException: 1 validation error detected: Value 'ap-northeast' at 'identityPoolId' failed to satisfy constraint: Member must satisfy regular expression pattern: [\w-]+:[0-9a-f-]+

identityPoolIdが誤っている。ユーザプールのIDを指定するのではなく、フェデレーテッドアイデンティティのIDを指定しないといけない。「ap-northeast-1:XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX」形式の値である。

## cognito-identity.amazonaws.com:subとは？
${cognito-identity.amazonaws.com:sub}をバケットポリシーに書いているけど、これは実際に何を指定するのか？これは、アイデンティティIDである。フェデレーテッドアイデンティティ > IDブラウザから確認できる。

## Vue.jsで非同期処理後のUI更新
S3上の画像を取得した後、表示を更新する必要があるが、オブジェクトを書き換えても表示できなかった。

[Vue.js で表示したデータの更新とイベント処理 | Cubix](http://chibinowa.net/note/vuejs/vue-2.html)を参考に、$setを利用するようにした。

<script src="https://gist.github.com/eiKatou/978c6fd9d8c5b20241a2e972157c695b.js"></script>


# 参考
以下のサイトを参考にして、無事に実装することができた。感謝！

- [aws/amazon-cognito-identity-js](https://github.com/aws/amazon-cognito-identity-js)
- [Amazon Cognito UserPools を JavaScript から使ってみる - Qiita](https://qiita.com/kusokamayarou/items/60bcf9d16ce0df93b0ea)
- [[ Serverless ] Cognito、S3、Lambdaで認証機能付きのWebサイトを作ってみました - Qiita](https://qiita.com/jobbin/items/d2fc0f714eb1f1cfc965)
- [[ Serverless ] Cognito、S3、Lambdaで認証機能付きのWebサイトを作ってみました<トラブルシューティング編> - Qiita](https://qiita.com/jobbin/items/a640bea19dfc13721246)
- [【ServerlessFramework】AWS LambdaとCognitoで作るセキュアなS3へのオブジェクト格納 - production.log](http://blog.naoshihoshi.com/entry/2017/04/17/153000)