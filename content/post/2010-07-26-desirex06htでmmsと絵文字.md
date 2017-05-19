---
title: Desire(X06HT)でMMSと絵文字
author: eiKatou
type: post
date: 2010-07-26T02:53:46+00:00
url: /33.html
archives:
  - 2010
tags:
  - Android

---
<div class="section">
  <p>
    今更ながら、MMSと絵文字の対応を行いました。
  </p>
  
  <p>
    <a href="http://f.hatena.ne.jp/Sirokoix/20100726115342" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/S/Sirokoix/20100726/20100726115342.jpg" alt="f:id:Sirokoix:20100726115342j:image" title="f:id:Sirokoix:20100726115342j:image" class="hatena-fotolife" /></a>
  </p>
  
  <h4>
    MMSインストール＆設定
  </h4>
  
  <p>
    <a href="http://blog.yo-ki.com/" target="_blank">こちら</a>から、使用しているROMに対応するMms.apkをダウンロードします。<a href="http://android.modaco.com/category/430/htc-desire-desire-modaco-com/" target="_blank">r6 WIP MoDaCo Custom ROM</a>を使用しているので、&#8221;Mms.apk.froyo.htc.jakeModExperimental2&#8243;をダウンロードしました。
  </p>
  
  <p>
    使用しているROMによって、使用するMms.apkが異なったり、Mms.apkが対応していなかったり、Mms.apkの入れ替え自体不要だったりするので、要注意です。
  </p>
  
  <ol>
    <li>
      /system/app/配下のMms.apkとMms.odexを削除します
    </li>
    <li>
      ダウンロードした&#8221;Mms.apk.froyo.jakeMod4&#8243;を&#8221;/system/app/Mms.apk&#8221;として置きます
    </li>
    <li>
      MMSアプリを起動して、設定画面を開きます
    </li>
    <li>
      カスタムUser-Agentを&#8221;Softbank V702NK2&#8243;に設定します
    </li>
  </ol>
  
  <h4>
    APNをMMS対応に変更
  </h4>
  
  <p>
    userとpasswordは、初期設定のままでOKです。MMS関係を追記しています。typeは空文字にしておくこと。APNはこの1つだけを登録しておきます。
  </p>
  
  <blockquote>
    <p>
      <?xml version="1.0" encoding="UTF-8"?>
    </p>
    
    <p>
      <apns>
    </p>
    
    <p>
      <apn name=&#8221;SoftBank Internet Plus MMS&#8221; numeric=&#8221;44020&#8243; mcc=&#8221;440&#8243; mnc=&#8221;20&#8243; apn=&#8221;open.softbank.ne.jp&#8221; user=&#8221;softbankX06HT&#8221; server=&#8221;null&#8221; password=&#8221;ほげほげ&#8221; proxy=&#8221;null&#8221; port=&#8221;null&#8221; mmsproxy=&#8221;sbmmsproxy.softbank.ne.jp&#8221; mmsport=&#8221;8080&#8243; mmsc=&#8221;http://mms/&#8221; authtype=&#8221;-1&#8243; type=&#8221;&#8221; />
    </p>
    
    <p>
      </apns>
    </p>
  </blockquote>
  
  <p>
    パスワードは自分のを入れてね。
  </p>
  
  <h4>
    絵文字インストール
  </h4>
  
  <ol>
    <li>
      <a href="http://cova.sakura.ne.jp/sb/" target="_blank">こちら</a>のページから、&#8221;絵文字結合済みフォント&#8221;をダウンロードします
    </li>
    <li>
      解凍したフォルダ内の&#8221;Helvetica.ttf&#8221;を&#8221;DroidSansFallback.ttf&#8221;にリネームします
    </li>
    <li>
      /system/font/配下に、DroidSansFallback.ttfを置きます。
    </li>
  </ol>
  
  <h4>
    絵文字辞書登録
  </h4>
  
  <p>
    Flick Wnn用ですが、辞書を作成してくれた方がいます。<a href="http://loda.jp/test1/?id=5" target="_blank">こちら</a>からダウンロードして、&#8221;user_dic.txt&#8221;にリネームして、Flick Wnnに辞書登録します。これで、簡単に入力できるようになりました。
  </p>
  
  <h4>
    その他
  </h4>
  
  <ul>
    <li>
      APNの設定を複数登録していると、type=&#8221;&#8221;のAPNを選択できなかった
    </li>
    <li>
      SoftbankのMMSのアドレスは<a href="https://my.softbank.jp/msb/d/top" target="_blank"> 
      
      <p>
        My SoftBank（マイソフトバンク） ホーム ｜ソフトバンクモバイル
      </p>
      
      <p>
        </a>からでも取得できます</li> 
        
        <li>
          MMS送受信はWifi接続では無理です
        </li></ul> 
        
        <h4>
          参考
        </h4>
        
        <ul>
          <li>
            <a href="http://blog.yo-ki.com/" target="_blank"><br /> Yokin’s Studio | iTheme最近の技術動向とわが社の命運をつれづれなるままに・・・<br /> </a>
          </li>
          <li>
            <a href="http://pocketgames.jp/blog/?p=5809" target="_blank">pocketgames PDA秘宝館 &#187; Blog Archive &#187; Nexus One で絵文字をよりキレイに表示</a>
          </li>
        </ul></div>
