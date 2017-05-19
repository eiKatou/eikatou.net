---
title: iOS開発：UILabelでリッチにテキスト表示（OHAttributedLabel）
author: eiKatou
type: post
date: 2012-08-18T02:02:42+00:00
url: /1994.html
archives:
  - 2012
tags:
  - Apple
  - Dev

---
[<img src="./uploads/2012/08/CoreTextLabelSample01.png" alt="" title="CoreTextLabelSample01" width="320" height="480" class="alignnone size-full wp-image-2000" srcset="./uploads/2012/08/CoreTextLabelSample01.png 320w, ./uploads/2012/08/CoreTextLabelSample01-200x300.png 200w" sizes="(max-width: 320px) 100vw, 320px" />][1]
  
UILabelの表示をカスタマイズしてみた。カスタマイズというのは、UILabel内のテキストの色を変えてみたり、リンクにしてみたり、、という事（上の写真を参照）。どうやら、CoreTextを使えば良いらしい。

しかし、CoreTextを使うのも難しそうなので、OSSの「OHAttributedLabel」（<https://github.com/AliSoftware/OHAttributedLabel>）を利用することにした。

<!--more-->

## OHAttributedLabelを使う

OHAttributedLabelを使うには、以下の４つをする必要がある。

  1. CoreText.frameworkをライブラリに追加
  2. OHAttributedLabelのソースを追加
  3. OHAttributedLabelのソースはARCを無効に
  4. Interface BuilderでLabelのクラスを変更

ARCを有効にしたプロジェクトでは、OHAttributedLabelのソースコードをARC無効にする（[EZ-NET: ファイル毎に ARC の有効・無効を設定する &#8211; Automatic Reference Counting][2]）。

あとは、そのままなので簡単。今回のサンプルプロジェクト（Xcode 4.4.1, iOS 5）を用意した。
  
[CoreTextLabelSample01][3]

## 文字色を設定する

色を設定する範囲と、文字色を指定する。
  
label.attributedTextに設定する前に、これらを設定する。
  
[c]
  
NSMutableAttributedString *attrStr = [NSMutableAttributedString attributedStringWithString:text];
  
NSRange range = [txt rangeOfString:@"ペヤング"];
  
UIColor *color = [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:1.0f];
  
[attrStr setTextColor:color range:range];
  
self.attrLabel.attributedText = attrStr;
  
[/c]

## リンクを設定する

リンクを設定するときも同じで、リンクにする文字範囲とリンク先を指定する。元の文字列がURLの時は、初めからリンクになるようだ。
  
[c]
  
NSRange linkRange = [txt rangeOfString:@"超激辛味噌ラーメン"];
  
NSURL *linkUrl = [NSURL URLWithString:@"http://www.google.com/"];
  
[self.attrLabel addCustomLink:linkUrl inRange:linkRange];
  
[/c] 

リンクの色を変更したい、リンクのアンダーラインを消したい、というときには、以下のコードを書けば良い。
  
[c]
  
[self.attrLabel setLinkColor:[UIColor redColor]];
  
self.attrLabel.underlineLinks = NO;
  
[/c] 

## 参考

  * [より豊かな表現のために、3つのステップで実装する Core Text (フェンリル | デベロッパーズブログ)][4]
  * [職人が教える！iOSアプリ開発で使いこなしたいとっておきのOSS：第4回　UILabelでのテキスト表示をリッチにする機能拡張サブクラス3種｜gihyo.jp … 技術評論社][5]

 [1]: ./uploads/2012/08/CoreTextLabelSample01.png
 [2]: http://program.station.ez-net.jp/special/objective-c/llvm/arc/enable-file.asp
 [3]: ./uploads/2012/08/CoreTextLabelSample01.zip
 [4]: http://blog.fenrir-inc.com/jp/2011/10/core_text_sample.html
 [5]: http://gihyo.jp/dev/serial/01/ios_oss/0004?page=1
