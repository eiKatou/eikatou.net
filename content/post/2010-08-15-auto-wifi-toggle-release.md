---
title: Auto WiFi Toggleを公開
author: eiKatou
type: post
date: 2010-08-15T14:17:30+00:00
url: /34.html
tags:
  - Android
  - App

---
初のAndroidアプリケーションを公開しました。



## Auto WiFi Toggle(説明サイト)

<a href="https://sites.google.com/site/titanandroidapps/auto-wifi-toggle-ja" target="_blank">Auto WiFi Toggle(日本語) &#8211; Titan Android Apps</a>



## Auto WiFi Toggle(日本語説明) 

<span style="color:#FF0000;">(2010年12月) この説明は古いです。上の説明サイトが最新です。</span>

WiFiを自動でオフにするアプリケーションです。

WiFiがオンの状態でWiFi未接続状態だと、常にWiFiをスキャンし続けるので、バッテリー消費量が上がります。WiFiが未接続状態を検知して、自動でWiFiをオフにしてます。これにより、バッテリー消費を抑えることができます。一瞬だけWiFiが切れる場合は、ディレイタイムを設定する事で、WiFiをオンの状態に保つことができます。

※ 常にアプリケーションを動作させる必要はありません。WiFi切断を検知して起動します。

※ Wi-Fiのスリープ設定は&#8221;スリープにしない&#8221;がおすすめです。

※ 現在、WiFi自動オンはできません。がんばって実装する予定です。

<a href="http://f.hatena.ne.jp/Sirokoix/20100815223407" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/S/Sirokoix/20100815/20100815223407.jpg" alt="f:id:Sirokoix:20100815223407j:image" title="f:id:Sirokoix:20100815223407j:image" class="hatena-fotolife" /></a>

<a href="http://f.hatena.ne.jp/Sirokoix/20100815223406" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/S/Sirokoix/20100815/20100815223406.jpg" alt="f:id:Sirokoix:20100815223406j:image" title="f:id:Sirokoix:20100815223406j:image" class="hatena-fotolife" /></a>



## Auto WiFi Toggleダウンロード

<a href="http://market.android.com/search?q=pname:com.appspot.eikatou0.autowifionoff" target="_blank">Auto WiFi Toggle</a>(Android携帯からアクセスしてね)

<a href="https://sites.google.com/site/titanandroidapps/auto-wifi-toggle" target="_blank">こちら</a>にQRコードがあります



## おまけ(Androidアプリケーション作成のポイント)

AndroidのアプリケーションはJavaで作成できるので簡単です。ただ、Android自体の仕組みを理解する必要があります。Javaを理解している事はもちろん、Androidの知識も必用です。

Androidの仕組みのポイントは、

  * Activity
  * Intent
  * Service
  * Content Provider

の4つです。

これを、書籍で理解してから取り組むとよいです。以下の書籍を参考にしました。

<div class="hatena-asin-detail">
  <a href="http://www.amazon.co.jp/dp/4048679562/?tag=hatena_st1-22&#038;ascsubtag=d-ehaef"><img src="http://ecx.images-amazon.com/images/I/51IyqtaGu-L._SL160_.jpg" class="hatena-asin-detail-image" alt="Google Androidプログラミング入門" title="Google Androidプログラミング入門" /></a></p> 
  
  <div class="hatena-asin-detail-info">
    <p class="hatena-asin-detail-title">
      <a href="http://www.amazon.co.jp/dp/4048679562/?tag=hatena_st1-22&#038;ascsubtag=d-ehaef">Google Androidプログラミング入門</a>
    </p>
    
    <ul>
      <li>
        <span class="hatena-asin-detail-label">作者:</span> <a href="http://d.hatena.ne.jp/keyword/%B9%BE%C0%EE%BF%F2" class="keyword">江川崇</a>,<a href="http://d.hatena.ne.jp/keyword/%C3%DD%C3%BC%BF%CA" class="keyword">竹端進</a>,<a href="http://d.hatena.ne.jp/keyword/%BB%B3%C5%C4%B6%C7%C4%CC" class="keyword">山田暁通</a>,<a href="http://d.hatena.ne.jp/keyword/%CB%E3%CC%EE%B9%CC%B0%EC" class="keyword">麻野耕一</a>,<a href="http://d.hatena.ne.jp/keyword/%BB%B3%B2%AC%C9%D2%C9%D7" class="keyword">山岡敏夫</a>,<a href="http://d.hatena.ne.jp/keyword/%C6%A3%B0%E6%C2%E7%BD%F5" class="keyword">藤井大助</a>,<a href="http://d.hatena.ne.jp/keyword/%C6%A3%C5%C4%C2%D9%B2%F0" class="keyword">藤田泰介</a>,<a href="http://d.hatena.ne.jp/keyword/%BA%B4%CC%EE%C5%B0%CF%BA" class="keyword">佐野徹郎</a>
      </li>
      <li>
        <span class="hatena-asin-detail-label">出版社/メーカー:</span> <a href="http://d.hatena.ne.jp/keyword/%A5%A2%A5%B9%A5%AD%A1%BC%A1%A6%A5%E1%A5%C7%A5%A3%A5%A2%A5%EF%A1%BC%A5%AF%A5%B9" class="keyword">アスキー・メディアワークス</a>
      </li>
      <li>
        <span class="hatena-asin-detail-label">発売日:</span> 2009/07/01
      </li>
      <li>
        <span class="hatena-asin-detail-label">メディア:</span> 大型本
      </li>
      <li>
        <span class="hatena-asin-detail-label">購入</span>: 17人 <span class="hatena-asin-detail-label">クリック</span>: 380回
      </li>
      <li>
        <a href="http://d.hatena.ne.jp/asin/4048679562" target="_blank">この商品を含むブログ (59件) を見る</a>
      </li>
    </ul>
  </div>
  
  <div class="hatena-asin-detail-foot">
  </div>
</div>

あと、忘れてはいけないのは、公式サイトです。基本は全て公式サイトに載っているので、公式サイトは必読です。

<a href="http://developer.android.com/index.html" target="_blank">Android Developers</a>

アプリケーションを公開する前にパッケージ名を再考しましょう。パッケージ名を間違えると、アプリケーションを再登録する必要があります。間違えたアプリは消せないです・・。
