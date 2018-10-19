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

今回作成していたのは、Webページをスクレイピングして、結果をSlackに通知するアプリ。細かい技術的なところは[Qiita](https://qiita.com/)を見ると分かるので、今後も引っかかりそうなところをメモしておく。

# Goでスクレイピング
Webページをスクレイピングするために、[goquery - GoDoc](https://godoc.org/github.com/PuerkitoBio/goquery) を使わせていただいた。

> jQuery's stateful manipulation functions (like height(), css(), detach()) have been left off.

基本はjQueryのセレクタが使えるのだけど、一部は対応していないので注意。

# Goのプロジェクトの配置場所

# Goのライブラリ管理

# SAMを使う

# Goを使ってみて


