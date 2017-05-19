---
title: iOS開発：MyTweet+リリース
author: eiKatou
type: post
date: 2012-12-16T01:30:30+00:00
url: /2222.html
archives:
  - 2012
tags:
  - App
  - Apple
  - Dev

---
ようやく、私のiOSアプリ（[MyTweet+][1]）がリリースされました！
  
[MyTweet+ （iTunes App Store）][1]
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet1-200x300.jpg" alt="" title="20121216_mytweet1" width="200" height="300" class="alignnone size-medium wp-image-2230" srcset="/uploads/2012/12/20121216_mytweet1-200x300.jpg 200w, /uploads/2012/12/20121216_mytweet1.jpg 320w" sizes="(max-width: 200px) 100vw, 200px" />][2] 

な、長かった〜

## どんなアプリ？

MyTweet+は、ツイートを管理するアプリ。お気に入りにしたツイートを、後から見返したい時などに便利。「あのトリビアなんだっけ・・？Twitterで見たけど思い出せない・・」って時に、サッとツイートを取り出すことができる。

今の機能はこんな感じ。

  * お気に入りツイート、自分のツイートを読み込み
  * ツイートをタグで管理
  * タグがついたツイートを表示
  * ツイートのローカル保存（画像キャッシュもあり）
  * 保存したツイートの検索
  * 過去のツイートのダウンロード

<!--more-->

## 使い方

使い方は簡単。ツイートにタグをつけて、すぐに取り出せるようにする。

### その１（お気に入りを読み込み）

一覧が表示される。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet2-200x300.jpg" alt="" title="20121216_mytweet2" width="200" height="300" class="alignnone size-medium wp-image-2229" srcset="/uploads/2012/12/20121216_mytweet2-200x300.jpg 200w, /uploads/2012/12/20121216_mytweet2.jpg 320w" sizes="(max-width: 200px) 100vw, 200px" />][3]

ツイートを確認。この うさぎさんの画像がお気に入り。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet3-200x300.jpg" alt="" title="20121216_mytweet3" width="200" height="300" class="alignnone size-medium wp-image-2228" srcset="/uploads/2012/12/20121216_mytweet3-200x300.jpg 200w, /uploads/2012/12/20121216_mytweet3.jpg 320w" sizes="(max-width: 200px) 100vw, 200px" />][4] 

### その２（タグをつける）

右上の「Tag」ボタンを押すと・・、タグの一覧が表示あれるので、「ワンコ＆ネコ」のタグにチェックを入れて「Save」する。（ツッコミなしで・・）
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet4-200x300.jpg" alt="" title="20121216_mytweet4" width="200" height="300" class="alignnone size-medium wp-image-2227" srcset="/uploads/2012/12/20121216_mytweet4-200x300.jpg 200w, /uploads/2012/12/20121216_mytweet4.jpg 320w" sizes="(max-width: 200px) 100vw, 200px" />][5] 

### その３（タグからツイートを見つける）

下にあるタブバーの「Tag」を押すと、作成したタグの一覧が表示される。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet5-200x300.jpg" alt="" title="20121216_mytweet5" width="200" height="300" class="alignnone size-medium wp-image-2226" srcset="/uploads/2012/12/20121216_mytweet5-200x300.jpg 200w, /uploads/2012/12/20121216_mytweet5.jpg 320w" sizes="(max-width: 200px) 100vw, 200px" />][6] 

先ほど保存した「ワンコ＆ネコ」をクリックすると、タグをつけた一覧が表示される。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet6-200x300.jpg" alt="" title="20121216_mytweet6" width="200" height="300" class="alignnone size-medium wp-image-2225" srcset="/uploads/2012/12/20121216_mytweet6-200x300.jpg 200w, /uploads/2012/12/20121216_mytweet6.jpg 320w" sizes="(max-width: 200px) 100vw, 200px" />][7]

もちろんツイートも見られるし、うさぎさん画像も見ることが出来る。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet7-200x300.jpg" alt="" title="20121216_mytweet7" width="200" height="300" class="alignnone size-medium wp-image-2223" srcset="/uploads/2012/12/20121216_mytweet7-200x300.jpg 200w, /uploads/2012/12/20121216_mytweet7.jpg 320w" sizes="(max-width: 200px) 100vw, 200px" />][8][<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet8-200x300.jpg" alt="" title="20121216_mytweet8" width="200" height="300" class="alignnone size-medium wp-image-2224" srcset="/uploads/2012/12/20121216_mytweet8-200x300.jpg 200w, /uploads/2012/12/20121216_mytweet8.jpg 320w" sizes="(max-width: 200px) 100vw, 200px" />][9]

## 使ってみた感想

自分のために、自分で作っておきながら、感想を書いてみる。

自分のやりたい事は実現できてるし、それなりに使っている。しかし、これといった決め手がないような気がする・・。なんだろう・・？、といった感じ。もう一歩、何かが足りない。

でも、「無料だから許せるか」と思ってリリースしちゃった。無料なので、お試ししてみてください。埋もれてるツイートを、また見返すことが出来るようになりますよ。
  
[MyTweet+ （iTunes App Store）][1]（注意：iOS6専用です）

 [1]: https://itunes.apple.com/us/app/mytweet+/id581752631
 [2]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet1.jpg
 [3]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet2.jpg
 [4]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet3.jpg
 [5]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet4.jpg
 [6]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet5.jpg
 [7]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet6.jpg
 [8]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet7.jpg
 [9]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121216_mytweet8.jpg
