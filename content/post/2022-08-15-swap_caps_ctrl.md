---
title: "WindowsでのCapLockキーとControlキーの入れ替え"
date: 2022-08-15T07:12:39+09:00
author: eiKatou
type: post
url: /20220815.html
archives:
  - 2022
tags:
  - Windows
---

WindowsでのCapLockキーとControlキーの入れ替え。


<!--more-->

# PowerToysを使うと問題が
今まで[Microsoft PowerToys](https://docs.microsoft.com/ja-jp/windows/powertoys/)を使っていた。

こんな感じでのキーの再マップを設定している状態。
![powertoys](/uploads/2022/08/sharpkeys1.png)

しばらくはうまく使えていたんだけど、クリップボードの履歴（Windowsキー + v）からの貼付けができないことに気がついた。クリップボードの履歴から貼り付けようとすると、CapsLockが押される状態。そして「V」が入力される。

たぶん、Control+vを発行していて、PowerToysでCapsLock+vに置き換えられているように見える。

# SharpKeysを使う
鉄板の方法はレジストリをいじることだけど、それをやりやすくしてくれるSharpKeysというアプリが出ていた。今回はSharpKeysを使って、CapsLockとControlキーの入れ替えをしていくことにした。

SharpKeysはMicrosoft Storeからインストールしました。  
[sharpkeys - Microsoft Store アプリ](https://apps.microsoft.com/store/detail/sharpkeys/XPFFCG7M673D4F)

## SharpKeysの設定
起動した直後の画面。Addを押して設定を追加していく。
![sharpkeys](/uploads/2022/08/sharpkeys2.png)

CapsLockをControlに割り当てる設定。キーを選んでOKを押す。Type Keyを押すと、直接キー入力を拾ってくれるので楽に設定できる。
![sharpkeys](/uploads/2022/08/sharpkeys3.png)

入れ替えなので、ControlをCapsLockにする設定も入れて、2つの設定になった。Write To Registoryを押して、レジストリに書き出す。
![sharpkeys](/uploads/2022/08/sharpkeys4.png)

レジストリエディタで確認すると、きちんと書き込まれていた。
![sharpkeys](/uploads/2022/08/sharpkeys5.png)

## 動作確認
事前にPowerToysのキー割当を削除しておく。

CapsLockがControlに割り当てられていることを確認した。ControlがCapsLockとして動くことも確認できた。クリップボードの履歴からの貼り付けも問題なし。
