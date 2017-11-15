---
title: "Webページ高速化を目指してWebPを導入"
date: 2017-11-16T05:02:49+09:00
author: eiKatou
type: post
url: /20171116.html
archives:
  - 2017
tags:
  - Web
---

最近、Webサイト高速化の話題が多いなと感じている。こんな本が出たりしている。ヨドバシカメラで見かけて、思わず買いかけた。電子版を年末年始に読む予定。

<a href="https://www.amazon.co.jp/dp/B0728K5JZV/ref=as_li_ss_il?_encoding=UTF8&btkr=1&linkCode=li2&tag=eikatou-22&linkId=66c58e826f4f81c38e46bde51666b315" target="_blank"><img border="0" src="//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B0728K5JZV&Format=_SL160_&ID=AsinImage&MarketPlace=JP&ServiceVersion=20070822&WS=1&tag=eikatou-22" ></a><img src="https://ir-jp.amazon-adsystem.com/e/ir?t=eikatou-22&l=li2&o=9&a=B0728K5JZV" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />

[Webフロントエンド ハイパフォーマンス チューニング｜Amazon](http://amzn.to/2AQeVVe)  
[Webフロントエンド ハイパフォーマンス チューニング | 技術評論社](http://gihyo.jp/book/2017/978-4-7741-8967-3)

<!--more-->

インターネットの世界では、次の記事が話題になっていた。確かにdev.toは早かった。ネイティブアプリかと思うぐらい早い。異常なレベル。

- [リニューアルした日経電子版が高速すぎてヤバイ件｜こんぴゅ｜note](https://note.mu/konpyu/n/n9fd5b81f6305)
- [「爆速すぎて笑う」　表示速度が“異常な”Webサイト「dev.to」　その仕組みは - ITmedia NEWS](http://www.itmedia.co.jp/news/articles/1711/15/news133.html)

# WebPを試す
このブログは静的サイトなので、Webアプリに比べると早い方であるけど、もっと早くしたいという気持ちになっている。dev.toレベルを目指したい。CDNは導入済み。

すぐに試せそうなWebPを試してみた。試す前に、WebP（ウェッピー）とは何かを学んでおく。

- [WebPのインストール方法と簡単な使い方 - Qiita](https://qiita.com/itosho/items/50636b1b3ff7e83dc0f2)
- [WebPでモバイルアプリの通信量を劇的に削減する - クックパッド開発者ブログ](http://techlife.cookpad.com/entry/2014/12/04/090000)

ただし、WebPは全てのブラウザでサポートされているわけではない。
[サポート状況](https://caniuse.com/#feat=webp)を確認すると、Safariが未対応！これは導入できない。。

[11日目: WebP使ってみた - わすれっぽいきみえ](http://kimikimi714.hatenablog.com/entry/2016/12/11/080000)では、pictureタグを使う方法をレクチャーしてくれている。

    <picture>
        <source type="image/webp" srcset="hoge.webp">
        <img src="hoge.jpg">
    </picture>

でも、HugoでMarkdownでサクサクと書きたい自分には、このコードを埋めるのはめんどくさい。ピンポイントで入れるぐらいかと思っている。

# インストールとWebP変換
HomeBrewでインストールした。

    $ brew install webp

mario.pngを90％の品質でwebp形式に変換。

    $ cwebp -q 90 mario.png -o mario_90.webp

[Googleのサイト](https://developers.google.com/speed/webp/download)からダウンロードもできる。

# WebPの画像を比べる
圧縮後のファイルサイズは、以下であった。品質90だとファイルサイズが上がっているけれど、品質70ぐらいなら約半分ぐらいのサイズ。

| ファイル | サイズ(byte) |
| ------- | ------- |
| オリジナルjpeg | 199745 |
| WebP(品質90) | 220322 |
| WebP(品質80) | 144882 |
| WebP(品質70) | 109856 |
| WebP(品質60) | 97848 |
| WebP(品質50) | 85238 |

以下、Chromeだと画像が表示されます。

オリジナルjpeg
![mario_org](/uploads/2017/11/mario.jpg)

WebP(品質90)
![mario_90_webp](/uploads/2017/11/mario_90.webp)

WebP(品質80)
![mario_80_webp](/uploads/2017/11/mario_80.webp)

WebP(品質70)
![mario_70_webp](/uploads/2017/11/mario_70.webp)

WebP(品質60)
![mario_60_webp](/uploads/2017/11/mario_60.webp)

WebP(品質50)
![mario_50_webp](/uploads/2017/11/mario_50.webp)

元の画像が粗いので分かりにくいけど、品質を落としても違和感がない。

# 思ったこと
Webサイトではブラウザの対応状況が良くないので、全面的な導入は難しそう。でも、Webベースのコンテンツを表示するネイティブアプリならば使えそうだと思った。

早くSafariで見えるようになって欲しい。IEは・・。
