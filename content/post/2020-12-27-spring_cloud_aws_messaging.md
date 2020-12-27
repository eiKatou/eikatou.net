---
title: "Spring Cloud AWSでメッセージングを試す"
date: 2020-12-27T15:39:24+09:00
author: eiKatou
type: post
url: /20201227.html
archives:
  - 2020
tags:
  - AWS
  - IT技術
---

[Spring Cloud for Amazon Web Services](https://spring.io/projects/spring-cloud-aws)を使って、メッセージングを行うサンプルを作った。前から気になっていたので、年内に触れて良かった。

サンプルプロジェクトは[example/Spring/SQSApp - GitHub](https://github.com/eiKatou/example/tree/master/Spring/SQSApp)
にあります。

<!--more-->

# アプリケーションの起動でエラーになる
[Spring Initializr](https://start.spring.io/)でダウンロードしたプロジェクトを起動しようとしてもエラーになる。[spring-cloud-starter-awsがローカル環境でエラーになる場合の最低限の対応 - 文系プログラマによるTIPSブログ](https://www.bunkei-programmer.net/entry/2019/01/26/232605)で書かれている通りで、EC2上で動かすことを前提にしているようだ。

ローカルで動かす設定にしても、[EC2 metadata resolution related exception thrown when running application locally · Issue #556 · spring-cloud/spring-cloud-aws · GitHub](https://github.com/spring-cloud/spring-cloud-aws/issues/556)と同じエラーが出力される。一応動いてはいるが、エラーメッセージが気になる。仕方なくloggingの設定でエラーを見なくしている。いいのかこれ。

これらを合わせて、[application.yml](https://github.com/eiKatou/example/blob/master/Spring/SQSApp/src/main/resources/application.yml)のようになった。

# アプリケーションの作り
公式サイト [5. Messaging](https://cloud.spring.io/spring-cloud-static/spring-cloud-aws/2.0.0.RELEASE/multi/multi__messaging.html) に書かれている通りで動く。Spring Bootのアプリケーションに簡単に統合できるのがいいなと思った。

## メッセージ削除のポリシー
@SqsListenerでメッセージを待ち受ける事ができるんだけど、メッセージを削除するタイミングが分からなかった。メッセージを削除方法はdeletionPolicyで指定できる。[HelloMessageReceiver.kt](https://github.com/eiKatou/example/blob/master/Spring/SQSApp/src/main/kotlin/com/example/demo/HelloMessageReceiver.kt)ではSqsMessageDeletionPolicy.ON_SUCCESSを指定するようにした。これで例外の発生時にメッセージを削除しないような動きにできる。

## @SqsListenerのカスタマイズ
@SqsListenerでのメッセージ待ち受けのカスタマイズもできる。[SqsConfig.kt](https://github.com/eiKatou/example/blob/master/Spring/SQSApp/src/main/kotlin/com/example/demo/config/SqsConfig.kt#L37)のように記載することで、スレッド数の変更やSQSからの取得数の変更が可能。

## ショートポーリング
以下のIssueが上がっているので、ショートポーリングを使っているようだ。APIのリクエスト数が増えそうだ。

[Enable long polling in QueueMessagingTemplate · Issue #646 · spring-cloud/spring-cloud-aws · GitHub](https://github.com/spring-cloud/spring-cloud-aws/issues/646)

