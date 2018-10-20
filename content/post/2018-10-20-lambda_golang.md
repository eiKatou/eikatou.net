---
title: "AWS LambdaをGolangで作る"
date: 2018-10-20T07:36:57+09:00
author: eiKatou
type: post
url: /20181020.html
archives:
  - 2018
tags:
  - AWS 
  - Dev
  - Golang
---

どこかの世界線でGolangが流行っていると聞いたので、AWS LambdaのアプリをGolangで書いてみた。

<!--more-->

今回作成していたのは、Webページをスクレイピングして、結果をSlackに通知するアプリ。環境周りで悩んだところをメモしておく。

# Goの開発環境
IntelliJ IDEA Ultimateを持っているならば、IntelliJで良いと思う。これ高いよね。

無料の開発環境を探して、VS CodeにGoのプラグインを入れて使うことにした。
[[Visual Studio Code][Golang][Windows] VSCodeでGoの開発環境を作成する方法まとめ - Qiita](https://qiita.com/koara-local/items/8642d847831b6268d23e)を見つつ、ひたすら拡張を入れていくだけ。

デバッグもVS Code上でできるので便利。

# Goのプロジェクトの配置場所
自分のPCにGoのプロジェクトを置く時、どこに置くかという問題。一般的には「$GOPATH/src/GitHubホスト名/GitHubリポジトリ名」とするらしい。

今回はAWS GodeCommitを利用したので、以下のような形になった。  
$GOPATH/src/git-codecommit.ap-northeast-1.amazonaws.com/v1/repos/Project

AWS Codebuildを使うと、上記の場所にcloneされるので、合わしておかないとコンパイルできないことになる。

[他言語から来た人がGoを使い始めてすぐハマったこととその答え - Qiita](https://qiita.com/mumoshu/items/0d2f2a13c6e9fc8da2a4)

# Goのライブラリ管理
Goのライブラリ管理は[GitHub - golang/dep: Go dependency management tool](https://github.com/golang/dep)。Goのオフィシャルチームが作っているということで、今後はこれが主流になると思う。

[Goオフィシャルチーム作成の依存関係管理ツール dep を試してみた ｜ DevelopersIO](https://dev.classmethod.jp/go/dep/)

# Goのビルドファイル
Goのプロジェクトでビルドは、Makefileを使うらしい。
懐かしいものが出てきたなと思いつつ、Makefileを書いた。

<script src="https://gist.github.com/eiKatou/d7a9d175327715026ddc3c02be3376c3.js"></script>

# Goでデバッグ用コードを埋め込む
デバッグの時だけXXしたいという時は、コンパイル時にtagsオプションを利用する。  
[Golang Cafe #25 まとめ デバッグとリリースビルドの切り替え方法を考える - taknb2nchのメモ](http://d.hatena.ne.jp/taknb2nch/20140414/1397459204)

# Goでスクレイピング
Webページをスクレイピングするために、[goquery - GoDoc](https://godoc.org/github.com/PuerkitoBio/goquery) を使わせていただいた。

> jQuery's stateful manipulation functions (like height(), css(), detach()) have been left off.

基本はjQueryのセレクタが使えるのだけど、一部は対応していないので注意。

# SAMを使う
今回、サーバレスということで、AWS SAMを使った。  
[awslabs/serverless-application-model: AWS Serverless Application Model (AWS SAM) prescribes rules for expressing Serverless applications on AWS.](https://github.com/awslabs/serverless-application-model)

template.yamlを書けば、Cloudformationのテンプレートを作成してくれる。思っている以上に簡単だった。

SAM localを使えば、AWS Lambdaのテストをローカルでも実施することができる。便利！

# Go langを使ってみた感想
他の言語を触っている人ならば、比較的に早く習得できると思う。シンプルで良い言語だと思った。Googleが開発元というので、すごく良い印象がある。気に入ったぜ。

マイナス面は、Javaと比較すると標準ライブラリに物足りなさを感じる。あと、Web系のフレームワークでスタンダードなものがないのが気になるところ。これから出てくると思うので、今後に期待。