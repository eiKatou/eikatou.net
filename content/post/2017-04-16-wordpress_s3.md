---
title: WordPressのブログをAWS S3で公開する
author: eiKatou
type: post
date: 2017-04-16T09:36:29+00:00
url: /3247.html
archives:
  - 2017
tags:
  - AWS
  - Dev
  - Web

---
WordPressを動かすにはPHPやMySQLが必要なため、どうしてもレンタルサーバを借りることになってしまう。このブログもWordPressを利用しており、さくらのレンタルサーバ スタンダードを使っていた。このレンタルサーバのお値段は1年間で5,142円。メモ書き程度にしか使っていないブログで、この値段は高い、と思っていたところに、AWS S3を使ってホスティングする方法を見つけた。

この方法は、自分のPC内でWordPressを起動させ、そのWordPressを静的HTMLに出力して、それを外部に公開する方法となる。そのため、WordPressが持つ全ての機能が動くわけではない。例えば、コメント機能や予約投稿などの機能が使えなくなってしまう。 

現在、さくらインターネット上で稼働しているWordPressをAWS S3に移行する。また、独自ドメイン「eikatou.net」を使っているため、このドメインでアクセスできるよう設定を行う。 

以下の2つのサイトを参考に実施していく。
  
<a href="http://www.simpline.co.jp/tech/?p=1203" target="_blank">S3で独自ドメインを使用して静的ウェブサイトをセットアップしてみる</a>
  
<a href="http://qiita.com/Ichiro_Tsuji/items/c174d580587a622d3358" target="_blank">独自ドメインを使ってAmazon S3で静的Webサイトをホストする</a> 

<!--more-->

# AWS S3の利用料は？

事前に、AWS S3の利用料を調べておく。
  
<a href="https://aws.amazon.com/jp/s3/pricing/" target="_blank">AWS S3料金</a> 

リクエスト回数とデータ転送量で料金が決まる。何の根拠もない数字だけど、10,000リクエスト＋データ転送量5GBだとすると、$0.01＋$0.14*5で$0.71。100円ぐらいの想定である。ただし、S3は大量のリクエストが来た場合でも処理できてしまうため、料金が青天井となる可能性がある。AWSの請求アラートを設定しておくのをお勧めする。 

# WordPressを静的HTMLにする

「<a href="https://ja.wordpress.org/plugins/static-html-output-plugin/" target="_blank">WP Static HTML Output</a>」というプラグインを利用する。

Base Urlに、自分のブログのトップアドレスを入力する。Start static site exportボタンを押すと、HTMLファイルが作成されていく。ブラウザの通知を有効にすると、バックアップが完了した時点で通知が行われる。その通知を押すと、ダウンロードできるリンクが表示される。

静的HTMLにする前に、ブログのパーマリンク設定を変更しておこう。”http://xxxx/2017/04/13/”のようなURLでは静的HTMLにできないからだ。管理画面の設定＞パーマリンクで、カスタム構造を選んで、”/%post_id%.html”を入れるようにした。 

# AWS S3にファイルを配置する

以下の内容を順に実施していく。
  
・バケット作成
  
・AWS CLIコマンドのインストール
  
・S3にアップロード 

S3にファイルを配置するために、まずはバケットを作成する。これはAWSの公式ドキュメントにやり方が載っている。ここを見ながら設定する。
  
<a href="http://docs.aws.amazon.com/ja_jp/AmazonS3/latest/dev/HostingWebsiteOnS3Setup.html" target="_blank">例: 静的ウェブサイトをセットアップする</a>

注意点は、独自ドメインを設定するときは、ドメインと同じ名前のバケット名にすること。このサイトはeikatou.netドメインを利用しているので、バケット名もeikatou.netとした。 

次はAWS CLIコマンドのインストール。
  
<a href="https://aws.amazon.com/jp/cli/" target="_blank">AWS コマンドラインインターフェイス</a>
  
<a href="https://pip.pypa.io/en/stable/installing/#installing-with-get-pip-py" target="_blank">Installing with get-pip.py</a>

自分のMacには、すでにPythonは入っていた。pipを入れる必要があるので、get-pip.pyを上記リンクからダウンロードして実行する。また、sixはすでにインストール済みであったため、ignoreオプションをつけている（これをつけないとエラーになった）。

<div class="code_box">
  $sudo python get-pip.py<br /> $sudo pip install awscli &#8211;upgrade &#8211;ignore-installed six
</div></p> 

AWS CLIコマンドの設定を行い、S3にアップロードする。
  
まずは、Access KeyとSecret Access Keyを登録する。

<div class="code_box">
  $aws configure<br /> AWS Access Key ID [None]: xxxxx<br /> AWS Secret Access Key [None]: xxxx<br /> Default region name [None]: ap-northeast-1<br /> Default output format [None]: json
</div>

S3のバケット内を確認。

<div class="code_box">
  $aws s3 ls s3://eikatou.net
</div>

S3のバケットとローカルフォルダを同期させる（アップロードされる）。「WP Static HTML Output」で出力したzipをダウンロードして解凍したフォルダを、自分のPCに置いている。

<div class="code_box">
  $aws s3 sync /Users/ei/www/eikatou.net s3://eikatou.net &#8211;exclude *.tmp &#8211;exclude .DS_Store
</div></p> 

# AWS S3にドメインの設定をする

今回は独自ドメインを使っているため、AWS S3に独自ドメインの設定をする。
  
・さくらインターネットのドメイン設定を削除
  
・AWS Route 53のホストゾーンを作成
  
・AWS Route 53のドメイン情報を設定（エイリアスレコードの追加）
  
・ムームードメインのネームサーバ書き換え 

<a href="https://help.sakura.ad.jp/hc/ja/articles/206056302-%E3%83%89%E3%83%A1%E3%82%A4%E3%83%B3%E8%A8%AD%E5%AE%9A%E3%81%AE%E5%89%8A%E9%99%A4" target="_blank">ドメイン設定の削除</a>を参考に、さくらインターネットで登録済みのドメイン設定を削除した。 

AWS Route 53の設定については、公式ドキュメントに記載があるので、それを参考に実施する。
  
<a href="http://docs.aws.amazon.com/ja_jp/AmazonS3/latest/dev/website-hosting-custom-domain-walkthrough.html#root-domain-walkthrough-switch-to-route53-as-dnsprovider" target="_blank">ステップ 3: Amazon Route 53 ホストゾーンを作成、設定する</a>

また、以下のサイトも非常に参考になった。
  
<a href="http://www.simpline.co.jp/tech/?p=1203" target="_blank">S3で独自ドメインを使用して静的ウェブサイトをセットアップしてみる</a>

エリアスレコードを追加するときは、作成したS3のバケットが出てくるので、それを選択すること。
  
[<img src="/blog/uploads/2017/04/170415-0004_2.jpg" alt="" width="800" height="593" class="alignnone size-full wp-image-3262" srcset="/blog/uploads/2017/04/170415-0004_2.jpg 800w, /blog/uploads/2017/04/170415-0004_2-300x222.jpg 300w, /blog/uploads/2017/04/170415-0004_2-768x569.jpg 768w, /blog/uploads/2017/04/170415-0004_2-405x300.jpg 405w" sizes="(max-width: 800px) 100vw, 800px" />][1] 

最後に、ムームードメインのネームサーバの設定を変更する。ここには、Route53のType「NS」レコードのサーバを設定する。
  
<a href="https://muumuu-domain.com/?mode=guide&#038;state=ns_other" target="_blank">ネームサーバのセットアップ方法（GMOペパボ以外のサービス）</a>

# 動作確認

ドメインでアクセスして、ブログが見えていることを確認した。

<a href="/3299.html" target="_blank">DockerでWordPress環境を構築する</a>に続く。

 [1]: /blog/uploads/2017/04/170415-0004_2.jpg
