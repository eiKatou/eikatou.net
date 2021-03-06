---
title: Mac：ファイルを右クリックして「このアプリケーションで開く」でアイコンが重複する
author: eiKatou
type: post
date: 2012-08-13T12:08:17+00:00
url: /1975.html
archives:
  - 2012
tags:
  - Apple

---
![_](/uploads/2012/08/mac_icon_tyouhuku1.jpg)
  
前から気になっていた現象。ファイルを右クリックして、「このアプリケーションで開く」を選ぶと、同じアイコンが並んでいる。

<!--more-->

## 解決法

ランチャ関係のデータベースを再構築するらしいと直るらしい。。
  
[bash]
  
$ cd /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/
  
$ ./lsregister -kill -r -domain system -domain local -domain user
  
[/bash]
  
ターミナルで上記コマンドを打って、再起動すると・・・。 

![_](/uploads/2012/08/mac_icon_tyouhuku2.jpg)
  
解決！ 

## 参考サイト

  * [KRAKENBEAL RECORDS: Mac OSX の context menu の「このアプリケーションで開く」でアイコンが重複した場合の修復方法][3]
  * [【コラム】OS X ハッキング! (180) Spotlightトラブル対策室 | パソコン | マイナビニュース][4]

* * *

こんなに簡単なら、OSアップデート時に自動でやっといてヽ(\`Д´)ﾉ

 [1]: /uploads/2012/08/mac_icon_tyouhuku1.jpg
 [2]: /uploads/2012/08/mac_icon_tyouhuku2.jpg
 [3]: http://krakenbeal.blogspot.jp/2010/11/mac-osx-context-menu.html?m=1
 [4]: http://news.mynavi.jp/column/osx/180/
