---
title: Auto WiFi Toggle 1.6.5 アップデート
author: eiKatou
type: post
date: 2012-08-08T06:12:47+00:00
url: /1920.html
archives:
  - 2012
tags:
  - Android
  - App
  - Dev

---
![_](/uploads/2012/08/AWT1.6.5.jpg)
  
Auto WiFi Toggleを1.6.5にアップデートしました。

主な修正は以下の点です。

  * Android 4.1への対応
  * 不具合修正 (QHD画面のレイアウト崩れ)

<!--more-->

## Android 4.1への対応

まずは、画面レイアウトの修正。未だにTabActivityを利用していますが、Android 4.0をターゲットにしてビルドしたので、ICS風のデザインに変わりました。

次は、WiFi P2Pへの対応。今までは、WiFiのステータスを取得するのに、以下のコードを利用していました。
  
[java]
  
ConnectivityManager connectivityManager = (ConnectivityManager)context.getSystemService(Context.CONNECTIVITY_SERVICE);
  
NetworkInfo networkInfo = connectivityManager.getNetworkInfo(ConnectivityManager.TYPE_WIFI);
  
if (ConnectivityManager.TYPE_WIFI != networkInfo.getType()) {
  
[/java]

今までは、必ずConnectivityManager.TYPE\_WIFIのオブジェクトが返ってきていたのですが、Android 4.1から(?)はConnectivityManager.TYPE\_WIFI_P2Pが返ってくる場合があります。WiFi P2Pで接続されているときは、WiFiをオフにする対応を行いました。WiFi P2Pが流行りだしたら、ここの仕様を考えようと思います。 

## 権限の修正

有料版の「Auto WiFi Toggle Plus」ですが、不要な権限がついていました。「端末の情報の読み取り」です。ライセンス認証で使うものだと思ってつけていましたが、不要でした。

## AdMobアップデート

AdMobの6.1.0に上げました。ADT r17でビルドすると、Proguardでエラーになってしまいましたが、ADT r20に上げると解消されました。なんだったんだろう・・

 [1]: /uploads/2012/08/AWT1.6.5.jpg
