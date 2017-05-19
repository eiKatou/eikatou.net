---
title: iOS開発：”Expression is not assignable.”エラー
author: eiKatou
type: post
date: 2012-08-14T00:18:09+00:00
url: /1981.html
categories:
  - Apple
  - Dev

---
iOSで開発をしていると、たまに&#8221;Expression is not assignable.&#8221;エラーに遭遇する。例えば、こんなコード。

[c]
  
CGSize size;
  
self.myLabel.frame.size.height = size.height;
  
[/c] 

訳の分からないエラーで泣きそうになったが、「[うたブログ～情報編: Xcode;Expression is no assignable][1]」を見て、ようやく理解。

「myLabel.frame」はプロパティへのアクセスで、「frame.size」は構造体メンバへのアクセス。これを混ぜているからエラーとなっている。

ということで、プロパティと構造体の箇所を分けてしまえばOK。
  
[c]
  
CGSize size;
  
CGRect frame = self.myLabel.frame;
  
frame.size.height = size.height;
  
[/c]

 [1]: http://info-utakura.blogspot.jp/2011/11/xcodeexpression-is-no-assignable.html
