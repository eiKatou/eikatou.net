---
title: Desire(X06HT)のRoot化後の設定
author: eiKatou
type: post
date: 1969-12-31T15:00:00+00:00
url: /27.html
tags:
  - Android

---
<div class="section">
  <h4>
    フォント入れ替え
  </h4>
  
  <ul>
    <li>
      <a href="http://acc.komugi.net/?%E6%89%8B%E9%A0%86%E6%9B%B8%2F%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E5%A4%89%E6%9B%B4" target="_blank">Android Custom Cookbookは終了しました。</a>
    </li>
  </ul>
  
  <p>
    ここにある通り、使いたいフォントをシステムに入れます。
  </p>
  
  <h4>
    カメラのシャッター音の無効化
  </h4>
  
  <ul>
    <li>
      <a href="http://www.yamakawa.us/android/236.html" target="_blank">yamakawa.us &#8211; HT-03Aのカメラのシャッター音を消す方法</a>
    </li>
    <li>
      <a href="http://lrl.mydns.jp:8080/blog/blog_pb/archives/2009/08/post-144/" target="_blank">無音oggファイル</a>
    </li>
  </ul>
  
  <p>
    カメラのシャッター音のoggファイルがシステム内にあるので、それを無音のoggファイルに置き替えます。
  </p>
  
  <h4>
    スリープからの復帰ボタンの変更
  </h4>
  
  <ul>
    <li>
      <a href="http://whitesc3.blog7.fc2.com/blog-entry-254.html#comment40" target="_blank">工人舎SC3 スリープ状態の Desire で、電源ボタン以外のボタンで復帰する方法</a>
    </li>
  </ul>
  
  <p>
    システム内の設定ファイルを書き換えで実現。
  </p>
  
  <h4>
    まとめると・・
  </h4>
  
  <p>
    SDカード内に、フォントファイルと無音oggファイルを置きます。リカバリモードで起動し、adb shellで端末にアクセスします。そして、以下のコマンド。
  </p>
  
  <pre class="syntax-highlight">
mount /sdcard/
mount /system/
cp /sdcard/tmp/font/DroidSansJapanese.ttf /system/fonts
vi /system/usr/keylayout/bravo-keypad.kl
cp <span class="synSpecial">-p</span> /system/media/audio/ui/camera_click.ogg /sdcard/tmp/camera_click.ogg
cp <span class="synSpecial">-p</span> /sdcard/tmp/nosound.ogg /system/media/audio/ui/camera_click.ogg
reboot
</pre>
</div>
