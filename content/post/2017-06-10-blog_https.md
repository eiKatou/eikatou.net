---
archives:
- 2017
author: eiKatou
date: 2017-06-10T22:02:15+09:00
tags:
- AWS
- Web
title: "ブログをHTTPS化した（ACMとCloudFront）"
type: post
url: /20170610.html
---

![blog https](/uploads/2017/06/blog_https1.png)

このブログをHTTPSに対応させた。  
AWSのAWS Certificate Manager(ACM)とCloudFrontを利用した。

<!--more-->

# 手順
HTTPSにするには、証明書の取得し、CloudFrontでコンテンツの配信を行う。

証明書は無料で取得できる。独自ドメインの証明書を取得するためには、そのドメインでメールを受け取れる必要がある。通常はメールサーバを立ててメールを受け取るのだが、SESを利用することでメールを受け取ることができるようだ。（すごいぞ、AWS！）

ということで、以下の手順となる。

+ SESでメールの受信設定
+ ACMで証明書の取得
+ CloudFrontの設定
+ Route 53でDNSの設定

以下のページが非常に参考になった。とても分かりやすい記事ばかりなので、このブログではポイントのみ書こうと思う。

- [Amazon S3 で運用しているブログを HTTPS 化した - rakuishi.com](https://rakuishi.com/archives/amazon-s3-cloudfront-acm/)
- [【そんなときどうする？】メールサーバはないけれどACMを使いたい！ – サーバーワークスエンジニアブログ](http://blog.serverworks.co.jp/tech/2016/06/30/acm-auth-method/)
- [[ACM] AWS Certificate Manager 無料のサーバ証明書でCloudFrontをHTTPS化してみた ｜ Developers.IO](http://dev.classmethod.jp/cloud/aws/acm-cloudfront-ssl/)
- [[ACM] SSL証明書発行時のドメイン認証メールをSESで受け取ってみた ｜ Developers.IO](http://dev.classmethod.jp/cloud/aws/acm-verifydomain-ses/)
- [WordPressサイトをCloudFrontで配信する - Qiita](http://qiita.com/Ichiro_Tsuji/items/38592e737257cb45ca13)

# ACMで証明書の取得
ACMでドメインを複数にした場合、全ドメイン分の認証メールを開いて認証しないと有効にならない。

# CloudFrontの設定
ここが一番ややこしいところ。

Origin Domain Nameの欄には、S3のバケット名ではなく、ホスティングURLを入れること。それしないと、"hostname/blog/"のようなURLで、index.htmlを返さずにエラーとなってしまう。  
[CloudFront に S3 bucket のサブディレクトリパスのコンテンツを参照させる - Qiita](http://qiita.com/naoiwata/items/3c6626cbeacbb44d4aa8)

Viewer Protocol Policyは、"Redirect HTTP to HTTPS"を選択することで、httpsへの自動転送を有効にした。

CloudFrontは設定反映に20分ほどかかる。すぐに設定が反映されないので要注意。CloudFront Distributionsページのstatusを確認すると分かる。

![cloudfront](/uploads/2017/06/blog_https2.png)

CloudFrontのTTLの設定を工夫することで、キャッシュ時間の調整ができるのだけど、このブログではTTLの設定は触らずに、CloudFrontのキャッシュをクリアするつもりである。キャッシュクリアの方法は、下の方で説明する。

# httpからの読み込みを修正
ページをhttps化しても、読み込むリソースにhttpが混じっていると、Chromeが警告を表示する。cssや画像もhttpsのリンクにしておく必要がある。hugoのconfig.tomlのbaseURLの値も、httpsに変更した。

# CloudFrontのキャッシュのクリア
一度キャッシュされると、htmlを変更しても反映されない。CloudFrontのキャッシュの消し方を覚えていると便利。こちらも数分かかる。  
[CloudFront エッジサーバのキャッシュ時間の制御 - Qiita](http://qiita.com/naoiwata/items/13a208ab02ad998ffab4)  

キャッシュを消すにはAWS CLIも利用可能。  
[create-invalidation — AWS CLI 1.11.102 Command Reference](http://docs.aws.amazon.com/cli/latest/reference/cloudfront/create-invalidation.html)

```bash
# プレビュー版のコマンドなので、初めだけ以下のコマンドが必要
aws configure set preview.cloudfront true
# キャッシュ削除
aws cloudfront create-invalidation --distribution-id XXXXXX \
  --paths /blog/ /blog/index.html /blog/index.xml 
```

キャッシュの指定の仕方は、本当にブラウザに入れるURLを指定すること。例えば、/blog/のキャッシュを削除したい時は、/blog/index.htmlを指定しても削除されない。/blog/を指定する必要がある。
