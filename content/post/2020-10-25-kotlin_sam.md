---
title: "KotlinのコードをAWS SAMでAWS Lambdaにデプロイする"
date: 2020-10-25T07:40:00+09:00
author: eiKatou
type: post
url: /20201025a.html
archives:
  - 2020
tags:
  - AWS
  - Dev
  - Kotlin
---

[KotlinのコードをAWS Lambda上で動かす](/20201011.html)の時はzipファイルをアップロードしていたけど、AWS SAMでデプロイするようにした。思った以上に簡単だった。いいね！

今回のコードは[リポジトリ](https://github.com/eiKatou/Sample/tree/master/Kotlin/awslambda)に置いている。

<!--more-->

# template.yamlを作る
[template.yaml](https://github.com/eiKatou/Sample/blob/master/Kotlin/awslambda/template.yaml)  
CodeUriにはzipファイルを指定すれば良い。今回はcronで定期的にLambdaを叩けるようにした。

# SAMでデプロイする
template.yamlからserverless-output.yamlを生成する。serverless-output.yamlを元にcloudformationを実行する。という流れになる。
```
./gralew clean
./gradlew buildZip

sam package \
    --template-file template.yaml \
    --output-template-file serverless-output.yaml \
    --s3-bucket <S3_BUCKET>

aws cloudformation deploy \
    --template-file serverless-output.yaml \
    --stack-name kotlinLambdaStack
```

cloudformationで作られたリソースは、Stackを削除することで綺麗に削除できる。後始末のお掃除をしておく。
```
aws-docker cloudformation list-stacks
aws-docker cloudformation delete-stack --stack-name kotlinLambdaStack
```
