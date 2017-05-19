---
title: FirefoxのTwitterアドオン
author: eiKatou
type: post
date: 2010-04-03T13:21:29+00:00
url: /8.html
tags:
  - Web

---
<div class="section">
  <p>
    FirefoxのアドオンでTwitterが流し読みできるものを探していて、以下のアドオンを見つけました。
  </p>
  
  <ul>
    <li>
      <a href="https://addons.mozilla.org/en-US/firefox/addon/5081" target="_blank">Echofon for Twitter :: Add-ons for Firefox</a>
    </li>
    <li>
      <a href="https://addons.mozilla.org/en-US/firefox/addon/7631" target="_blank">Twitbin :: Add-ons for Firefox</a>
    </li>
    <li>
      <a href="https://addons.mozilla.org/en-US/firefox/addon/6845" target="_blank">TwitKit :: Add-ons for Firefox</a>
    </li>
    <li>
      <a href="https://addons.mozilla.org/ja/firefox/addon/68161" target="_blank">no title</a>
    </li>
  </ul>
  
  <p>
    それぞれのアドオンを試してみた結果、TwitKit+が良さげでした。欲しかった機能としては、サイドバーでタイムラインの表示だったので、ちょうど良かったです。
  </p>
  
  <p>
    ただ、「more 100 tweets」で昔のTLを読んでいる時に、更新がかかると、リセットされます(泣)。これはなんとかして欲しい。
  </p>
  
  <p>
    FireGestureでTwitKit+のサイドバーを開くには、以下のスクリプトを割り当てます。
  </p>
  
  <pre class="syntax-highlight">
toggleSidebar(<span class="synConstant">&#34;viewTweetbar&#34;</span>);
</pre>
  
  <p>
    iPhoneやMac派の人は、「Echofon for Twitter」が良いんじゃないかと思います。同期なども出来るようです。UIもMacっぽいです。
  </p>
  
  <p>
    via
  </p>
  
  <ul>
    <li>
      <a href="http://netafull.net/firefox-addon/031179.html" target="_blank">&#91;N&#93; FirefoxでTwitterするための8つのアドオン</a>
    </li>
    <li>
      <a href="http://d.hatena.ne.jp/shom5w/20081021/1224590333" target="_blank">FireGestureスクリプト：TwitKitサイドバーを開く/閉じる &#8211; アーユルベーダはインドのエステみたいなもん</a>
    </li>
  </ul>
</div>
