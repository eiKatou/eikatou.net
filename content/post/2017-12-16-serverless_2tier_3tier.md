---
title: "サーバーレスアプリケーションの2-Tier Architectureと3-Tier Architecture"
date: 2017-12-16T15:37:24+09:00
author: eiKatou
type: post
url: /20171216.html
archives:
  - 2017
tags:
  - Dev
---

サーバレスアプリケーションを作っていて、2-Tier Architectureと3-Tier Architectureのどちらを選ぶべきなのかを悩んでいる。

[少し前に作ったアプリ](/20171119.html)は2-Tier Architectureで作っていて、会社の先輩に話すと「API Gatewayを入れた方が良い」との意見をいただいていた。なぜAPI Gatewayを入れた方が良いのか、きちんと考えておいた方がいいなと思った。

<!--more-->

# 2-Tier Architectureとは
クライアントから直接AWSサービスを呼び出す方式のアプリケーション。

![serverless 2tier](/uploads/2017/12/serverless_2tier_3tier.jpg)

[モバイル開発を支えるAWS Mobile Services](https://www.slideshare.net/keisuke69/aws-mobile-services)から引用。

# 3-Tier Architectureとは
2-Tier ArchitectureにAPI Gateway + Lambdaを挟んで、クライアントからはAPI Gatewayを呼び出すようにする。Lambdaにアプリケーションのビジネスロジックを集約させる方式。

# 2-Tier Architectureのメリット・デメリット
- サーバサイドの開発が不要なため、開発コスト・運用コストの削減が可能
- 簡単な権限制御は可能 [^1]
- 管理ユーザだけ全ユーザのデータにアクセスできるなどの細かい権限制御ができない [^2]
- 非力なクライアントやレガシーなクライアントでは動かない可能性がある
- ビジネスロジックの改修をするたびに、ユーザにクライアントを配布する必要がある（ネイティブアプリの場合）
- 必要なデータだけを取れない場合、通信量が多くなる

[^1]:[詳細に設定されたアクセスコントロールのための IAM ポリシー条件の使用 - Amazon DynamoDB](http://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/developerguide/specifying-conditions.html)  
[^2]:[モバイル／JavaScriptアプリで、Cognitoを利用した2-Tier構成とAPI Gatewayを利用した3-Tier構成の比較 - プログラマでありたい](http://blog.takuros.net/entry/2015/10/26/081923)

# 3-Tier Architectureのメリット・デメリット
- サーバサイドの開発が必要なため、開発コスト・運用コストが必要
- 細かい権限制御ができる
- クライアントにもつビジネスロジックを最小限にできるため、クライアントの幅が広がる。クライアントをネイティブアプリとWebアプリの両方にして、ビジネスロジックはサーバサイドで集約する事ができる
- クライアントに配布せずにビジネスロジックを修正可能

# どっちがいいの？
こうやって比較すると、2-Tier Architectureの最大のメリットは「サーバサイド開発が不要であること」だというのが分かる。つまり、以下のようなアプリケーションが向いているように思う。

- 簡単なアプリケーション
- 開発期間・開発コストを抑えたい
- 利用クライアントが限られている

3-Tier Architectureでは、以下のようなアプリケーションが向いているように思う。

- ある程度の複雑さを持つようなアプリケーション
- 複数種類のクライアントを想定している
- 今後の拡張性を持っておきたい

サーバサイドとクライアントサイドを分けて開発すると、意外と手間がかかる。API定義も必要だし、結合テストも増えるので、コストと時間がかかる。開発するリソース量が増えると、今後の改修時に修正量も増えることになる。とはいえ、後から3-Tier Architectureに変えるにはかなり大変そう。

基本的に3-Tier Architectureで作成し、期間やコスト面が厳しい時に2-Tier Architectureという選択肢を持っておくのが良いと考えた。
