---
title: ReadabilityにURLのみを送るブックマークレット
author: eiKatou
type: post
date: 2012-05-04T05:24:10+00:00
url: /1369.html
archives:
  - 2012
tags:
  - Web

---
[<img src="http://eikatou.net/blog/wp-content./uploads/2012/05/20120504_readability.png" alt="" title="20120504_readability" width="250" height="250" class="alignnone size-full wp-image-1372" srcset="./uploads/2012/05/20120504_readability.png 250w, ./uploads/2012/05/20120504_readability-150x150.png 150w" sizes="(max-width: 250px) 100vw, 250px" />][1]

最近、[Readability][2]を使い始めた。Instapaperよりもデザインが綺麗なところがお気に入り。

しかし、ブックマークレットが動かないことが多い。たとえば、[Stackoverflow][3]では「Saving・・」が出てこない。こんな時は、URLのみを送るブックマークレットを使うと良い。

以下をブックマークのアドレスに保存する。名前は「Later」とかにしておく。
  
<textarea name="javascript" rows="2" cols="10">javascript:window.location=&#8217;http://www.readability.com/save?url=&#8217;+encodeURI(window.location);</textarea> 

[stackoverflow][3]で保存したブックマークレット「Later」を押すと、以下の画面が表示される。真ん中のボタンを押すと保存できる。
  
[<img src="http://eikatou.net/blog/wp-content./uploads/2012/05/20120504b.png" alt="" title="20120504b" width="452" height="332" class="alignnone size-full wp-image-1374" srcset="./uploads/2012/05/20120504b.png 452w, ./uploads/2012/05/20120504b-300x220.png 300w, ./uploads/2012/05/20120504b-408x300.png 408w" sizes="(max-width: 452px) 100vw, 452px" />][4] 

* * *

Stackoverflowなど保存できないサイトは、Readabilityがコンテンツの取得に失敗しているようだ。

 [1]: http://eikatou.net/blog/wp-content./uploads/2012/05/20120504_readability.png
 [2]: http://www.readability.com/
 [3]: http://stackoverflow.com/
 [4]: http://eikatou.net/blog/wp-content./uploads/2012/05/20120504b.png
