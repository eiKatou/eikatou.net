---
title: ProguardのKeepでライブラリを難読化させない
author: eiKatou
type: post
date: 2012-03-03T05:34:19+00:00
url: /684.html
tags:
  - Android
  - Dev

---
Androidアプリを公開する前に、Proguardで難読化を実施している。Proguardを実施すると、クラス名とクラスメンバー名が書き換わる。しかし、いつも何かの機能が動かなくなる。

Gsonを使っていたときは、Gsonのライブラリまで難読化されてしまい、正常に動作しなくなってしまった（これで結構な時間を使った）。初歩的な点だけど、はまるとなかなか抜け出せなかったりする。

難読化しなくても良い物は、ProguardのKeepで難読化の対象外にしておこう。

<!--more-->

# ProguardのKeep指定

## ライブラリを使うとき

Gsonを使ったときの指定。Gsonのパッケージは、com.google.gson。その配下のクラスとクラスメンバーを難読化対象から外す。「\*\*」がポイント。「\*\*」は、そのパッケージだけでなく、サブパッケージも対象とする。
  
[java]
  
-keep class com.google.gson.**
  
[/java] 

## 自分のクラスを対象外にするとき

[java]
  
-keep class net.eikatou.ClassName
  
[/java]

## クラスのメンバーを対象外にするとき

[java]
  
-keepclassmembers class net.eikatou.ClassName
  
[/java]

# まとめると

[ProGuardで-keepオプションのメモ &#8211; superdry memorandum 😀][1]から引用。

<table border="4" align="center">
  <caption>Keep指定</caption> 
  
  <tr bgcolor="#eeeeee">
    <th>
      keepするもの
    </th>
    
    <th>
      リネームと削除をしない
    </th>
    
    <th>
      リネームをしない
    </th>
  </tr><tr align=center> 
  
  <td>
    クラスとクラスメンバ
  </td>
  
  <td>
    -keep
  </td>
  
  <td>
    -keepnames
  </td></tr> <tr align=center> 
  
  <td>
    クラスメンバのみ
  </td>
  
  <td>
    -keepclassmembers
  </td>
  
  <td>
    -keepclassmembernames
  </td></tr> <tr align=center> 
  
  <td>
    クラスメンバが存在した場合のクラスとクラスメンバ
  </td>
  
  <td>
    -keepclasseswithmembers
  </td>
  
  <td>
    -keepclasseswithmembernames
  </td></tr>
</table>

「リネームと削除しない」を選んでおいたら良いと思う。

# 動かなくなったときは・・

動かなくなったときは、とりあえず全部クラスをkeep指定にして動作確認する。それで動いたら一安心。少しずつkeep指定を外していき、何が問題なのかを追及する。

AndroidManifest.xmlに書いているクラスなどは、名前を変えてしまうと動かなくなるので注意。

* * *以下のページも参考になる。


  
[ProGuardマニュアル（13） 保全オプションの概観][2]</p>

 [1]: http://d.hatena.ne.jp/Superdry/20110121/1295641171
 [2]: http://d.hatena.ne.jp/m12i/20110416/1302942202
