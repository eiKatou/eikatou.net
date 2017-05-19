---
title: WordPressにRSS登録ボタンをつける
author: eiKatou
type: post
date: 2012-02-22T12:51:56+00:00
url: /795.html
archives:
  - 2012
tags:
  - Dev
  - Web

---
<img src="./uploads/2012/02/rss-info.png" alt="" title="RSSの登録" width="484" height="86" class="alignnone size-full wp-image-776" srcset="./uploads/2012/02/rss-info.png 484w, ./uploads/2012/02/rss-info-300x53.png 300w" sizes="(max-width: 484px) 100vw, 484px" />

「RSS登録はこちら」といった形で登録を促しているブログがある。Wordpressのプラグインかな、と思っていたが、見つからない。Google先生に聞いても、なかなか分からない。

半月も悩んだ結果、自分でテーマをカスタマイズして、表示できるようになった。

その方法を紹介する。

<!--more-->

# ボタンを作る

## RSS画像

[<img src="./uploads/2012/02/201202_wprss-300x287.jpg" alt="" title="201202_wprss" width="300" height="287" class="alignnone size-medium wp-image-828" srcset="./uploads/2012/02/201202_wprss-300x287.jpg 300w, ./uploads/2012/02/201202_wprss-313x300.jpg 313w, ./uploads/2012/02/201202_wprss.jpg 350w" sizes="(max-width: 300px) 100vw, 300px" />][1]
  
まずは、RSSのアイコン画像が必要。
  
これは、ネットからダウンロードする。「RSS アイコン」で画像検索すると良い。

おすすめは以下のリンク。

  * [Free of charge RSS Feed Icons][2]
  * [膨大なRSSアイコン。RSSアイコンをお探しの方はこちら。][3]
  * [Top RSS icon packs for your blog][4]
  * [RSSアイコンがいっぱい][5]

## 文字を入れる

意外に難しいのが、文字画像の生成。
  
普通のフォントではなく、かわいいフォントを使いたい。[フリーフォントで簡単ロゴ作成][6]を使うと、簡単にロゴの作成ができる。

[<img src="./uploads/2012/02/201202_fontlogo.jpg" alt="" title="201202_fontlogo" width="400" height="278" class="alignnone size-full wp-image-814" srcset="./uploads/2012/02/201202_fontlogo.jpg 400w, ./uploads/2012/02/201202_fontlogo-300x208.jpg 300w" sizes="(max-width: 400px) 100vw, 400px" />][7]
  
こんな感じで、お手軽にロゴが作成できる。 

## 画像の合成

あとは、２つの画像を合成するだけ。[前に買ったPixelmator][8]が活躍してくれた。こういう時ぐらいしか、活用していないな・・

# WordPressに組み込み

WordPressへの組み込みは、テーマを編集する。

私が使っているテーマは「Twenty Eleven」。編集するファイルは「single.php」。テーマによって、編集ファイルは違うかもしれない。

[html]
  
<?php get\_template\_part( &#8216;content&#8217;, &#8216;single&#8217; ); ?>

<div style="width:auto;margin: 0 auto;">
  
<a href="<?php bloginfo(&#8216;rss2\_url&#8217;); ?>" title="<?php \_e(&#8216;Syndicate this site using RSS&#8217;); ?>">
  
<img style="max-width: 97.5%;" src="./uploads/2012/02/rss-info.png" alt="RSSを登録する" title="RSSを登録する" />
  
</a>
  
</div>
  
<hr>
  
<?php comments_template( &#8221;, true ); ?>

[/html]
  
このように修正。コンテンツとコメントの間に入れるようにした。
  
RSSのURLは「bloginfo(&#8216;rss2_url&#8217;);」で取得できる。画像サイズはmax-widthを指定しないと、ウィンドウからはみ出るので注意。 

# まとめ

前からつけてみたかったRSSボタン。
  
ようやく、ボタンを表示することが出来た。

コメントの下にあるRSSボタンを押して、RSS登録してみてね。

* * *

[フリーフォントで簡単ロゴ作成][6]。意外と別の場面で役に立つかもしれない。覚えておくといいかも。

 [1]: http://nam0.deviantart.com/art/Rss-Icons-Orb-v2-41870546
 [2]: http://malevi4.wordpress.com/2008/05/09/free-of-charge-rss-feed-icons/
 [3]: http://e0166.blog89.fc2.com/blog-entry-298.html
 [4]: http://smashingwebs.com/2010/04/top-rss-icon-packs-for-your-blog/
 [5]: http://www.designwalker.com/seed/2007/11/rss-icon.html
 [6]: http://lightbox.on.coocan.jp/html/fontImage.php
 [7]: ./uploads/2012/02/201202_fontlogo.jpg
 [8]: http://eikatou.net/blog/2011/11/buy-pixelmator/
