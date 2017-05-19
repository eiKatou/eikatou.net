---
title: Android携帯のWiFiの運用
author: eiKatou
type: post
date: 2010-06-20T08:35:40+00:00
url: /28.html
archives:
  - 2010
tags:
  - Android

---
<div class="section">
  <p>
    私のDesire(X06HT)のWiFiの設定とおすすめのアプリを紹介します。
  </p>
  
  <h4>
    こんな風にWiFiを使いたい
  </h4>
  
  <ul>
    <li>
      自宅にいる時は自動でWiFi On。自動でAPに接続
    </li>
    <li>
      おでかけ中はWiFi Off
    </li>
  </ul>
  
  <h4>
    WiFi関係で使用しているアプリ
  </h4>
  
  <ul>
    <li>
      AutoWiFi(有料 100円也)
    </li>
    <li>
      WeFi Connect
    </li>
  </ul>
  
  <h4>
    AutoWiFiの設定
  </h4>
  
  <p>
    <a href="http://f.hatena.ne.jp/Sirokoix/20100620170620" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/S/Sirokoix/20100620/20100620170620.png" alt="f:id:Sirokoix:20100620170620p:image" title="f:id:Sirokoix:20100620170620p:image" class="hatena-fotolife" /></a>
  </p>
  
  <p>
    <a href="http://octoba.net/archives/20100601-autowifi-android-655.html" target="_blank">AutoWiFi : WiFiの状態を自動切り替えしてバッテリー節約！Androidアプリ655</a>
  </p>
  
  <p>
    AutoWifiの良いところは、位置情報を使ってWiFiをOn/Offしてくれるところです。WiFiのボタンを押したりするのが面倒くさい人にはおすすめです。今回は、位置情報で自宅を検出して、WiFiをOn/Offするように設定します。
  </p>
  
  <h5>
    設定のポイント(その１)
  </h5>
  
  <p>
    3Gネットワーク用の自宅位置を登録します。3Gネットワークの位置検出はかなりズレる(1Kmぐらい)ので、3Gネットワーク用の登録が必要です。GPSとWiFiをOffにして、3Gネットワークのみで位置検出した場所を自宅の場所として設定します。
  </p>
  
  <h5>
    設定のポイント(その２)
  </h5>
  
  <p>
    WiFi用の自宅位置を登録します。WiFiを使用した位置検出は正確なので、WiFiでの位置検出用にも設定を用意します。WiFiをOnにして、位置検出した場所を指定します。これで、位置情報は２つになります。
  </p>
  
  <h5>
    設定のポイント(その３)
  </h5>
  
  <p>
    &#8220;スリープ時は検出しない&#8221;を<span style="color:#FF0000;">ノーチェック</span>にします。ここをOnにしてしまうと、端末操作中のみの位置検出になってしまいます。常に位置検出できるようにしておかないと、自動でWiFiがOn/Offできませんよね。
  </p>
  
  <h4>
    WeFi Connectの設定
  </h4>
  
  <p>
    <a href="http://andronavi.com/2010/05/14766" target="_blank">『WeFi &#8211; Automatic WiFi』Wi-Fi接続?Wi-Fiを使いやすく? | andronavi (アンドロナビ)</a>
  </p>
  
  <p>
    WeFi Connectを使用しているのは、WiFiの接続がきれる事があるためです。たまに、WiFi On状態＆AP未接続の状態になります(なぜ？)。この状態からWiFiのAPに自動で接続を行いたいので、WeFiを利用しています。
  </p>
  
  <h5>
    設定のポイント
  </h5>
  
  <p>
    &#8220;Auto Connect&#8221;をONにするだけです。これで、接続履歴のあるAPに自動で接続してくれます。
  </p>
</div>
