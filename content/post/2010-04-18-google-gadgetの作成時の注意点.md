---
title: Google Gadgetの作成時の注意点
author: eiKatou
type: post
date: 2010-04-18T02:54:37+00:00
url: /17.html
archives:
  - 2010
tags:
  - Web

---
<div class="section">
  <h4>
    Twitterのつぶやきを表示させるGoogle Gadget
  </h4>
  
  <p>
    いろいろな目的があって、時間をかけて、役に立たないGoogle Gadgetを作ってしまいました。ですが、いろいろな目的は、達成されました。そのいろいろな目的は、こんなんです。
  </p>
  
  <ul>
    <li>
      JavaScriptを覚えたい(JSONPとか)
    </li>
    <li>
      TwitterAPIを使ってみたい
    </li>
    <li>
      はてなで、きれいにTwitterのつぶやきを表示させたい
    </li>
  </ul>
  
  <h4>
    Google Gadgetを作成する
  </h4>
  
  <p>
    Google Gadgetを作るのは意外と簡単。HTMLとJavaScriptの知識があればできます。
  </p>
  
  <ol>
    <li>
      作り方を解説しているページを熟読します(超重要) <ul>
        <li>
          <a href="http://code.google.com/intl/ja/apis/gadgets/" target="_blank">Gadgets API &#8211; Google Code</a>
        </li>
        <li>
          <a href="http://wiki.livedoor.jp/hogematomo/d/Google%A5%AC%A5%B8%A5%A7%A5%C3%A5%C8%A4%CE%BA%EE%A4%EA%CA%FD" target="_blank">Googleガジェットの作り方 &#8211; Google Gadgetのページ &#8211; livedoor Wiki（ウィキ）</a>
        </li>
        <li>
          <a href="http://zapanet.info/blog/item/1136" target="_blank">はじめてのiGoogleガジェット開発</a>
        </li>
      </ul>
    </li>
    
    <li>
      HTML+JavaScriptで実装して、ブラウザで動作確認
    </li>
    <li>
      HTML+JavaScriptで実装したものをGadget用XMLに移植
    </li>
  </ol>
  
  <h4>
    Google Gadgetを作成する際に気をつける点
  </h4>
  
  <h5>
    Userprefのlistデータ型
  </h5>
  
  <p>
    <a href="http://code.google.com/intl/ja/apis/gadgets/docs/fundamentals.html#Datatypes" target="_blank">開発の基礎 &#8211; Gadgets API &#8211; Google Code</a>のUserprefのlistデータ型。このリストの中身は、追加された順ではないです。なので、順番が重要なリストを用意したい時は、listデータ型は使えません。
  </p>
  
  <h5>
    Google Gadgets Editorの動作
  </h5>
  
  <p>
    <a href="http://code.google.com/intl/ja/apis/gadgets/docs/tools.html#GGE" target="_blank">デベロッパー ツール &#8211; Gadgets API &#8211; Google Code</a>の注意事項にもありますが、すべてのAPIをサポートしていません。makeRequest()をサポートしていないので、リモートコンテンツの確認ができません。
  </p>
  
  <h5>
    Gadgetの高さの自動調整
  </h5>
  
  <p>
    gadgets.window.adjustHeight();で、自動調整ができるはずですが、ブラウザによって挙動が異なります。いろいろなブラウザでテストしましょう。
  </p>
  
  <p>
    ポイントは、Gadgetの最後にsetTimeoutで呼び出すこと。
  </p>
  
  <pre class="syntax-highlight">
setTimeout(<span class="synIdentifier">function</span>() <span class="synIdentifier">{</span>gadgets.<span class="synStatement">window</span>.adjustHeight();<span class="synIdentifier">}</span>, 2000);
</pre>
</div>
