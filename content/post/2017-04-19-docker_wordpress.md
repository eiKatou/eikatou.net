---
title: DockerでWordPress環境を構築する
author: eiKatou
type: post
date: 2017-04-19T08:32:09+00:00
url: /3299.html
tags:
  - Web

---
[WordPressのブログをAWS S3で公開する][1]の続き。

前回はS3でブログを公開するところまでやったので、次はさくらインターネットのWordPressを止める必要がある。その前に自分のPCでWordPress環境を構築する。今回はDockerの勉強もかねて、Dockerを使って構築する。

# Dockerとは

<img src="/uploads/2017/04/docker_logo.png" alt="" width="600" height="206" class="alignnone size-full wp-image-3338" srcset="/uploads/2017/04/docker_logo.png 600w, /uploads/2017/04/docker_logo-300x103.png 300w, /uploads/2017/04/docker_logo-500x172.png 500w" sizes="(max-width: 600px) 100vw, 600px" />

Dockerは軽量の仮想化環境である。VirtualBoxなどの仮想化はハードウェアからのエミュレーションであるが、DockerはホストOSの上のレイヤーでの仮想環境である。下のリンクが分かりやすい。
  
・<a href="https://ja.wikipedia.org/wiki/Docker" target="_blank">WikiPedia Docker</a>
  
・<a href="http://www.atmarkit.co.jp/ait/articles/1701/30/news037.html" target="_blank">超入門Docker：第1回　Dockerとは</a>

ミドルウェア（ApacheやMySQLなど）を入れたイメージを作り、そのイメージをベースとしたコンテナを動かしていく。もし、ミドルウェアのバージョンアップがあった時は、コンテナを作り直して、コンテナを差し替える形で起動すれば良い。負荷分散などで複数サーバを立ち上げたい時は、同じように設定されたコンテナを複数起動させることができる。要は、アプリケーション環境を一つの箱に入れ込んで管理できるというもの。

今回はホストOS（Mac）の環境を汚すことなく、WordPress環境を作れるところもメリットだと思った。

<!--more-->

# Docker for Macのインストール

<a href="https://docs.docker.com/docker-for-mac/" target="_blank">Get started with Docker for Mac</a>
  
上記リンクから、Dockerをインストール。Dockerアプリを起動させると、Macの上のバーにクジラが出てくる。

# Docker ComposeでWordPress環境を構築

DockerでWordPress環境を構築するためには、MySQLとWordPressのイメージを利用する。このイメージはDockerHubで公開されている。オフィシャルと書いてあるので、信用できるものである。

MySQLとWordPressの2つのコンテナを使うので、Docker Composeを使う事にした。Docker Composeは以下のサイトの解説がわかりやすい。
  
・<a href="http://qiita.com/y_hokkey/items/d51e69c6ff4015e85fce" target="_blank">docker-composeを使うと複数コンテナの管理が便利に</a>

Dockerの公式サイトにWordPress環境構築のドキュメントがあるので、その通りに実行する。
  
<a href="https://docs.docker.com/compose/wordpress/" target="_blank">Quickstart: Compose and WordPress</a>

何も詰まることなく、あっけなくWordPress環境が立ち上がった。
  
localhost:8000 で繋いで見ると、初期画面が表示された。簡単すぎる！！

# 気になるところ

初期起動までは簡単だったけど、色々と気になるところが出てきた。

1つ目は、Data Volumeについて。Data Volumeは、コンテナの永続データを保存する仕組みのこと。永続データはData Volumeに入れるのが良いらしい。公式サイトのdocker-compose.ymlでは、WordPressの本体が入っている/var/www/htmlはData Volumeになっていない。画像のアップロード先でもあるので、Data Volumeにしておきたい。

2つ目は、MySQLのデータを編集するために、phpMyAdminを使えるようにしておきたい。

3つ目は、「WP Static HTML Output」を使おうとすると、&#8221;You are missing the zip extension”とメッセージが出て利用できない。以下のリンクに解決方法が出ているので、これを取り込むようにする。
  
<a href="https://github.com/docker-library/php/issues/52" target="_blank">PHP Zip Archive Enabled Fail #52</a>

# オレオレ版に改造

修正したDockerfileとdocker-composeは、GitHubにて公開している。
  
<a href="https://github.com/eiKatou/Sample/tree/master/Docker/WordPress" target="_blank">https://github.com/eiKatou/Sample/tree/master/Docker/WordPress</a>

まず、3つ目に対応するため、zip extensionをインストール済みのDockerイメージを作成する。WordPressの公式イメージを元に、zip
   
extensionをインストールしたものである。この対応のために、Dockerfileを作成する。Dockerfileはイメージを作るためのソースコードのようなものだ。Dockerfileの記述に沿って、イメージが構築される。

次はdocker-compose.ymlを修正する。修正点は以下のとおり。
  
・Dockerfileで作ったイメージを利用する
  
・phpMyAdminのコンテナを起動
  
・WordPressのデータ保存先をData Volumeにする
  
・WordPressは80番ポートで動かすようにする（元は8000番ポート） 

## Dockerfileとdocker-composeの準備

~/wordpress/配下に、以下の2ファイルを配置。
  
・Dockerfile
  
・docker-compose.yml

## イメージの作成

<div class="code_box">
  cd ~/wordpress<br /> docker build -t wordpress:20170419 ~/wordpress<br /> docker images
</div>

最後のコマンドで、wordpress:20170419のイメージができていることが確認できる。 

## WordPress起動

<div class="code_box">
  cd ~/wordpress/<br /> docker-compose up -d
</div>

## WordPressへのアクセス

WordPressへは以下のURLでアクセスする。
  
<a href="http://127.0.0.1/" target="_blank">http://127.0.0.1/</a>
  
127.0.0.1でなく、localhostで繋いでも良い。

phpMyAdminへのアクセスは以下のURL。
  
wordpress/wordpressでログインできる。
  
<a href="http://127.0.0.1:8080/" target="_blank">http://127.0.0.1:8080/</a> 

## WordPress停止

<div class="code_box">
  cd ~/wordpress/<br /> docker-compose down
</div>

# Dockerを使ってみて

Dockerで簡単にWordPress環境を作ることができた。また、自分のPCに直接ミドルウェアを入れる必要がないので、自分のPC環境を汚さずに、色々な環境をお試しで作ることができる。勉強するところは多いが、非常に便利なソフトウェアだと思った。Dockerは開発が続いているので、今後はもっと便利になっていくと思う。 

<a href="http://localhost/3350.html" target="_blank">Docker上のWordPressデータのバックアップ＆リストア</a>に続く・・

 [1]: http://localhost/3247.html
