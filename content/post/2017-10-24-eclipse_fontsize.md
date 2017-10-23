---
title: "Eclipseのよく使う設定"
date: 2017-10-24T06:45:00+09:00
author: eiKatou
type: post
url: /20171024.html
archives:
  - 2017
tags:
  - Dev
---

Eclipseでよく使う設定をメモしておく。また、MacでEclipseを使っていると文字が小さすぎて読めない問題があるんだけど、文字を大きくする方法が分かったのでメモしておく。

<!--more-->

# コンテンツアシストのキーを変更
[一般] > [キー] > [コンテンツ・アシスト]

私はCommand+Spaceを設定している。

# タブをスペースにする
[一般] > [エディタ] > [テキスト・エディタ]

タブをスペースにするなら、ここを修正。私はタブ派です。

# 文字コードを変更
[一般] > [ワークスペース] > [テキスト・ファイルのエンコード]

下の方に設定がある。

# エディタの文字を大きくする
[一般] > [外観] > [色とフォント] > [基本] > [テキスト・フォント]

フォントを大きくすると、エディタの文字が大きくなる。


# エディタ以外の文字を大きくする
パッケージエクスプローラの文字が大きくなる。Mac版は小さすぎて読めないです。

[Mac版Eclipseの文字のサイズを大きくする | karakaram-blog](http://www.karakaram.com/eclipse-font)

    1. FinderでEclipse.appのところまで行く。
    2. Eclipse.appを選択して右クリック、「パッケージ内容を表示」を選択
    3. Contents/MacOS/eclipse.iniを開く
    4. -Dorg.eclipse.swt.internal.carbon.smallFonts　を削除（2行あるので注意）
    5. eclipse再起動

[Pleiades All in One](http://mergedoc.osdn.jp/)のEclipseを使っている時は、Contents/Eclipse/eclipse.iniを修正する。