---
title: JavaScriptの動的スクリプトローディング
author: eiKatou
type: post
date: 2010-01-01T15:00:00+00:00
url: /16.html
tags:
  - Web

---
<div class="section">
  <p>
    ブログパーツを作っていたんだけど、どうしてもブログパーツ内でjQueryが使いたい。という事で、動的スクリプトローディングを調べていました。ブログパーツ内でjQueryを使う場合で、良さげな方法が２種類。
  </p>
  
  <h4>
    １つ目
  </h4>
  
  <ul>
    <li>
      <a href="http://d.hatena.ne.jp/amachang/20071116/1195202294" target="_blank"> 動的スクリプトローディング（さんざん既出だと思うけど &#8211; IT戦記</a>
    </li>
    <li>
      <a href="http://blog.bornneet.com/Entry/114/" target="_blank">遅延ロードでJavaScriptのお勉強 &#8211; Born Neet</a>
    </li>
  </ul>
  
  <p>
    む、むずかしい・・。コードが読めないよ。
  </p>
  
  <p>
    欠点は、元のHTMLでjQueryが始めに読み込まれている場合にjQueryが読み込まれない事。これは、ブログパーツならではの問題かな。がんばって、いろいろと書き換えてみたけど、どうも無理っぽい。
  </p>
  
  <p>
    でも、ブログパーツに限定しなければ、これは使える!!よめないけど・・。
  </p>
  
  <h4>
    ２つ目
  </h4>
  
  <ul>
    <li>
      <a href="http://tech.kayac.com/archive/jquery-blogparts-base.html" target="_blank">blogpartsでjQueryを使うときの読み込み方 | tech.kayac.com &#8211; KAYAC engineers’ blog</a>
    </li>
  </ul>
  
  <p>
    こちらが本命。ブログパーツ内でjQueryが使えます。ただ、<span style="font-weight:bold;">jQueryのコードをコピペしないといけない</span>。データ量が増えるのは厳しい。
  </p>
  
  <p>
    なにか良い方法はないものか。
  </p>
</div>
