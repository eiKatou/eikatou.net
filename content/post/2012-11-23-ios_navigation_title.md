---
title: iOS開発：ナビゲーションバーのタイトルを変更する
author: eiKatou
type: post
date: 2012-11-23T01:16:24+00:00
url: /2090.html
archives:
  - 2012
tags:
  - Apple
  - Dev

---
先日、なかなか解決できなかった点。以下のコードで、ナビゲーションバーのタイトルを変更しようとした。
  
[c]
  
self.title = @"Tweet";
  
[/c]
  
すると、タブのタイトルも一緒に変わってしまう（以下の画像の枠の箇所）。
  
[<img src="/uploads/2012/11/ios_navigationbar_title-208x300.png" alt="" title="ios_navigationbar_title" width="208" height="300" class="alignnone size-medium wp-image-2091" srcset="/uploads/2012/11/ios_navigationbar_title-208x300.png 208w, /blog/uploads/2012/11/ios_navigationbar_title.png 320w" sizes="(max-width: 208px) 100vw, 208px" />][1]

ナビゲーションバーのタイトルのみを変更したいのだ。タブのタイトルは変更したくない。そういう時は、以下のようにすれば良い。
  
[c]
  
self.navigationItem.title = @"Tweet";
  
[/c]
  
この問題を解決するのに、意外と時間がかかってしまった。

self.titleは、なぜ両方のタイトルを変えるような仕様になっているのだろう・・。分かりにくいなぁ。

 [1]: /blog/uploads/2012/11/ios_navigationbar_title.png
