---
title: "Pocketに保存したURLをSlackに通知するアプリを作った"
date: 2020-11-15T17:56:39+09:00
author: eiKatou
type: post
url: /20201115.html
archives:
  - 2020
tags:
  - AWS
  - Dev
  - Kotlin
---

[Pocket](https://app.getpocket.com/)に保存したURLをSlackに通知するアプリを作った。

<!--more-->

# 日頃の課題
日頃、[Pocket](https://app.getpocket.com/)に後で読みたいサイトを保存している。でも、保存した時点で満足してしまって、読まないことがほとんど。せっかく有用なサイトを見つけたのに勿体無い。いつでも読めるようになると、読まなくなるという不思議。。

これを催促するための何かが欲しいと思っていた。

# 解決方法
Pocketに溜まっているサイトから、Slackで毎朝通知する方法にした。Slackのリマインダーでも良いんだけど、リマインダーだと[Pocket](https://app.getpocket.com/)にアクセスして、どれを読むか探さないといけない。少しでも手間を減らしたいので、SlackにURLを通知する形にした。

欲しい機能は以下のもの。
- [Pocket](https://app.getpocket.com/)に保存しているサイトからランダムで1つ通知する
- 通知タイミングは毎朝で、通知方法はSlackとする。
- 通知内容は、サイトのタイトルとURLとする。

# 完成した通知
![slack_pocket](/uploads/2020/11/slack_pocket.png)

毎朝、目につくようになったので、保存したサイトを見る機会は確実に増えた。

# 使った技術
以下の技術を使った。
- AWS Cloudwatch
- AWS Lambda
- AWS SAM
- Kotlin

AWS CloudwatchでAWS Lambdaをキック。AWS Lambdaで動くアプリケーションはKotlinで作成した。インフラの構成の補助にAWS SAMを利用した。

本当はコードも公開したかったけど、secret keyを埋め込んだままなので非公開にしている。いつか、AWS KMSでキーを隠せるようにしてGitHubにあげたい。

[Pocket: Developer API](https://getpocket.com/developer/)は闇が多く、めちゃくちゃ使いにくかった。
- 未読のサイトをとるのに、HTTP POSTメソッドを使っている
- 取得できるJSONのlistがarray型ではない。キーに謎のIDが入っている。

JSONはこんな感じ。"list"の周りが・・
```json
{
  "status": 1,
  "complete": 1,
  "list": {
    "3102647521": {
      "item_id": "3102647521",
      "resolved_id": "3102647521",
      "given_url": "https://qiita.com/moritalous/items/35ec898b6e239f3b9b21",
      "given_title": "",
      "favorite": "0",
      // 続く・・
```

# 今後の発展
以下は改善したいところ。
- Slack上からアーカイブ or 削除を行いたい。Slackにボタンとかつけたい。
- KMSなどでシークレットキーを暗号化して、ソースを公開する。
- CodePipelineでビルドからデプロイを自動化する。