---
title: はてなでTwitterのつぶやきを表示させる(Google Gadget)
author: eiKatou
type: post
date: 2010-04-16T02:08:21+00:00
url: /15.html
categories:
  - Web

---
<div class="section">
  <p>
    前回、作成したGoogle Gadget。はてなでは、ブログパーツが使えないとのことで、Google Gadgetを作成しました。
  </p>
  
  <p>
    こんな感じで書いています。
  </p>
  
  <pre class="syntax-highlight">
&#60;script src=<span class="synConstant">&#34;http://gmodules.com/ig/ifr?url=http://eikatou0.appspot.com/gadets/tweet01/tweetGadgets.xml&#38;up_tweetTitle=%E4%BB%8A%E6%97%A5%E3%81%AE%E6%B3%A8%E7%9B%AETweet%21%21&#38;up_tweetIds=12279963640,12269816963,12258327892&#38;synd=open&#38;w=400&#38;h=700&#38;title=&#38;border=%23e5ecf9&#38;output=js&#34;</span>&#62;&#60;/script&#62;
</pre>
  
  <p>
    タイトルと、表示させるTweetを変える時は、以下の手順を行います。
  </p>
  
  <ol>
    <li>
      タイトルを入れます。&#8221;&up_tweetTitle=<span style="font-weight:bold;">title</span>&#8220;のところに、タイトルを入力。日本語の場合はURLエンコードします。<a href="http://home.kendomo.net/board/decode/" target="_blank">URL エンコード/デコードフォーム</a>
    </li>
    <li>
      つぶやきIDを調べます。 <ol>
        <li>
          Twitterのホーム画面を開きます
        </li>
        <li>
          気になるtweetの時間のリンクをクリックします
        </li>
        <li>
          URLの&#8221;<a href="http://twitter.com/user/status/11223344556" target="_blank">http://twitter.com/user/status/11223344556</a>&#8220;の<span style="font-weight:bold;">数字部分(&#8220;11223344556&#8221;)</span>
        </li>
      </ol>
    </li>
    
    <li>
      &#8220;&up_tweetIds=<span style="font-weight:bold;">id1,id2</span>&#8220;のところに、表示させたいつぶやきIDを並べます<span class="footnote"><a href="/Sirokoix/#f1" name="fn1" title="カンマ区切りで複数並べられます">*1</a></span>
    </li>
    <li>
      &#8220;&w=400&h=700&#8243;で高さと幅を調整します
    </li>
  </ol>
  
  <p>
    その他のパラーメータについては、<a href="http://labs.unoh.net/2007/08/google_1.html" target="_blank">ウノウラボ by Zynga Japan: ブログパーツ貼り付けタグのまとめ＋Googleガジェット＠はてな</a>が詳しいです。外枠の色とかサイズが変えられます。
  </p>
</div>

<div class="footnote">
  <p class="footnote">
    <a href="/Sirokoix/#fn1" name="f1">*1</a>：カンマ区切りで複数並べられます
  </p>
</div>
