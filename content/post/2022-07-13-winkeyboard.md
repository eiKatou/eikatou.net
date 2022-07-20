---
title: "WindowsとMacで1つのキーボードを利用する"
date: 2022-07-13T09:07:48+09:00
author: eiKatou
type: post
url: /20220713.html
archives:
  - 2022
tags:
  - Apple
  - Windows
  - 雑記
---

[以前買ったHHKB Professional2 US配列](20180512.html)をWindowsとMacの両方で扱うようにした。

<!--more-->
# HHKBの設定
[HHKB Professional2の説明書](https://www.pfu.fujitsu.com/hhkeyboard/manual/p1pa50951-1380_02.pdf)を見ながら設定。

DIPスイッチを以下のように設定して、Lite Ext.モードに変更。
- 1と3をオン。
- 2,4,5,6はオフ。

ひし形マークのついたキーが、WindowsではWinキー、MacではCommandキーで動くようになった。

# WindowsとMacのショートカットキーを合わせる
WindowsはControlキーを多用して、MacはCommandキーを多用することになる。両方を使っていると、この2つの違いで押し間違いが発生。常にイライラしている状態だった。

基本的にWindowsのキー設定に合わせることにした。
例えば、Macでもこんな風にしたい。
- Control+c：コピー
- Control+v：貼り付け
- Control+z：戻す

# 対応方法1
Macのキーボードショートカットを変更する方法。
システム環境設定 > キーボード > 修飾キーで、ControlキーでCommandキーを入力できるようにする。

この方法だと本当にControlキーを使いたい時に困ることになる。例えば、ブラウザでタブを切り替え（Control+tab）を押すと、アプリ切り替え（Command+tab）になってしまう。いろいろと不都合が出てしまう。

# 対応方法2
Karabinar Elementsを使う方法。
特定のキーが押されたときのみ、別のキー入力に変換してくれる。こちらの方法だと細かく指定できるので良い。

例えば、こんな感じになる。
- Control+cを押したとき、Karabinar Elementsが入力を変換してCommand+cが発行される。
- Control+vを押したとき、Karabinar Elementsが入力を変換してCommand+vが発行される。
- Control+tabを押したときは、そのままControl+tabが発行される。

参考にしたページ。  
[[Mac]キーボードのCtrlキーとCommandキーを一部だけ入れ替える(Karabinar Elementsの導入から設定編） | 演劇とかの感想文ブログ](https://blog.kansolink.com/develop/iphone/howtochange-ctrl-cmd-for-somekey/)

自分用にカスタマイズしたものをおいておきます。  
https://github.com/eiKatou/dotfiles/blob/master/karabiner/mac_control_cvxz.json


