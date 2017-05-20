---
archives:
- 2017
author: eiKatou
date: 2017-05-20T09:20:00+09:00
tags:
- Web
title: "WordPressを捨ててHUGOに乗り換え"
type: post
url: /20170520.html
---

このブログをHUGOで再構築した。 WordPressとはさようならです。
少し前にWordPressが動くDockerも用意したけど、あれは良い勉強だったと思うことにする。

<!--more-->

# WordPressの不満
WordPressは便利だったけど、以下の点が不満だった。

- 記事を書く時にHTMLタグを書かないといけない
- 起動までが遅い。起動しっぱなしだったとしても、画面表示が遅い。
- 遅い（特にプラグイン「WP Static HTML Output」が）


# HUGOとは？
[HUGO](https://gohugo.io)

静的HTMLを出力するソフトウェア。記事はマークダウンで書く。go言語で作られている。

# HUGOを使って見て
ファイルを作って、マークダウンで内容を書いて、コマンドを叩けばHTMLが出来上がる。それをサーバーに送るという流れになる。PC内でサーバーを起動するコマンドもあるので、作成中もPCで動作確認もできる。

やっぱり、マークダウンで書くのは楽。エディタで簡単に書けるので、HTMLタグを書く必要も無くなった。HTMLの生成も20秒もかかっておらず、とても早い。

## テーマ
テーマは「[Beautiful Hugo](https://themes.gohugo.io/beautifulhugo/)」を使用している。

## テーマを修正したところ
以下の点はテーマを修正した。

- CSSを1つにまとめる
- CSSで記事のフォントを変更
- JavaScriptを1つにまとめる
- tagとarchiveのページを作成
- サブディレクトリ（/blog/）で動くように修正

これらの修正も含めて、このブログのソースはGitHubで公開している。  
https://github.com/eiKatou/eikatou.net

# まとめ
[Archives](./archives/)のページを作って、2010年から7年もブログが続いていたことに驚いた。過去を見返していたら、すごく懐かしかった。

