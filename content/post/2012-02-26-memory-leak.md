---
title: Androidアプリのメモリリークを調査する
author: eiKatou
type: post
date: 2012-02-26T08:48:17+00:00
url: /853.html
archives:
  - 2012
tags:
  - Android
  - Dev

---
<img src="/blog/uploads/2012/02/System-Memory-icon.png" alt="" title="System-Memory-icon" width="128" height="128" class="alignnone size-full wp-image-914" />
  
Androidアプリを開発していると、たまにOutOfMemoryに遭遇する。そういう時に便利な、メモリリークの調査方法を紹介する。

以下のサイトを参考にさせてもらった。

  * [Memory Analysis for Android Applications][1]
  * [メモリリークを発見！Androidアプリのメモリ解析手法][2]

上記のサイトは、手順がわかりにくい箇所もあったので、補足の意味で書こうと思う。

# メモリリークを調査するには？

メモリリークを調査する、と言われても、なかなかピンとこない。しかし、やっていることは簡単。

  1. アプリケーションを操作する
  2. ガベージコレクション(GC)を走らせる
  3. ヒープメモリの状態を取得
  4. ヒープメモリを見る
  5. ガベージコレクション(GC)で回収できていないメモリを探す

という５つの手順だけ。これで回収できていないメモリがあれば、回収できるように参照を消したりする必要がある（ここが難しい）。

<!--more-->

# アプリケーションを操作する

エミュレータ上でアプリケーションを動かす。アプリケーションを操作する前に、DDMSのUpdate Heapボタンを押しておく。
  
[<img src="/blog/uploads/2012/02/201202_memory1.jpg" alt="" title="201202_memory1" width="600" height="388" class="alignnone size-full wp-image-865" srcset="/blog/uploads/2012/02/201202_memory1.jpg 600w, /blog/uploads/2012/02/201202_memory1-300x194.jpg 300w, /blog/uploads/2012/02/201202_memory1-463x300.jpg 463w" sizes="(max-width: 600px) 100vw, 600px" />][3]
  
緑色のタンクみたいなアイコンのボタンが、Update Heapボタン。

アプリケーションをいろいろと動かしてみる。調査したい機能が決まっているならば、その機能だけを動かすのもあり。
  
[<img src="/blog/uploads/2012/02/201202_memory2.jpg" alt="" title="201202_memory2" width="400" height="370" class="alignnone size-full wp-image-868" srcset="/blog/uploads/2012/02/201202_memory2.jpg 400w, /blog/uploads/2012/02/201202_memory2-300x277.jpg 300w, /blog/uploads/2012/02/201202_memory2-324x300.jpg 324w" sizes="(max-width: 400px) 100vw, 400px" />][4]
  
画像を使っている箇所は、メモリ回収できないと、OutOfMemoryが出る可能性があるので、入念にチェックしたい。

一通りの操作が終わったら、アプリケーションを閉じる。アプリケーションが前面に出ていないように。メイン画面まで戻って、Homeボタンを押す。１機能の調査ならば、その機能を終了させる。

# ガベージコレクション(GC)を走らせる

ガベージコレクション(GC)を走らせるのもボタン１つ。
  
[<img src="/blog/uploads/2012/02/201202_memory3.jpg" alt="" title="201202_memory3" width="600" height="388" class="alignnone size-full wp-image-869" srcset="/blog/uploads/2012/02/201202_memory3.jpg 600w, /blog/uploads/2012/02/201202_memory3-300x194.jpg 300w, /blog/uploads/2012/02/201202_memory3-463x300.jpg 463w" sizes="(max-width: 600px) 100vw, 600px" />][5]
  
Cause GCボタンを押すだけ。いつも３回ぐらい連打している。

# ヒープメモリの状態を取得

ヒープメモリの状態を取得するには、Dump HPROF fileボタンを押す。
  
[<img src="/blog/uploads/2012/02/201202_memory4.jpg" alt="" title="201202_memory4" width="600" height="388" class="alignnone size-full wp-image-870" srcset="/blog/uploads/2012/02/201202_memory4.jpg 600w, /blog/uploads/2012/02/201202_memory4-300x194.jpg 300w, /blog/uploads/2012/02/201202_memory4-463x300.jpg 463w" sizes="(max-width: 600px) 100vw, 600px" />][6]
  
これでヒープメモリの情報がファイルで出力される。
  
HPROFは、Java標準のプロファイラ。そのプロファイラで解析する。

# ヒープメモリを見る

[hprof-convコマンド][7]を使って、標準のhpof形式のファイルを作成する。
  
[java]
  
hprof-conv net.eikatou.xx.hprof xx.hprof
  
[/java]
  
hprof-convコマンドは、Android SDKに入っている。「/android-sdk-mac_x86/platform-tools/hprof-conv」。 

出来上がったhprofファイルを[jhatコマンド][8]に渡す。
  
[java]
  
jhat xx.hprof
  
[/java]
  
jhatはJavaのSDKに入っている。

jhatコマンドを実行後に「http://localhost:7000/」にアクセスすると、ヒープの内容が表示される。
  
[<img src="/blog/uploads/2012/02/201202_memory5.jpg" alt="" title="201202_memory5" width="600" height="529" class="alignnone size-full wp-image-902" srcset="/blog/uploads/2012/02/201202_memory5.jpg 600w, /blog/uploads/2012/02/201202_memory5-300x264.jpg 300w, /blog/uploads/2012/02/201202_memory5-340x300.jpg 340w" sizes="(max-width: 600px) 100vw, 600px" />][9] 

# ガベージコレクション(GC)で回収できていないメモリを探す

ヒープの内容が表示されたら、自分のクラスの中身を確認する。
  
[<img src="/blog/uploads/2012/02/201202_memory6.jpg" alt="" title="201202_memory6" width="400" height="303" class="alignnone size-full wp-image-907" srcset="/blog/uploads/2012/02/201202_memory6.jpg 400w, /blog/uploads/2012/02/201202_memory6-300x227.jpg 300w, /blog/uploads/2012/02/201202_memory6-396x300.jpg 396w" sizes="(max-width: 400px) 100vw, 400px" />][10]
  
自分のクラスのページを開いて、さらに下にスクロール。

[<img src="/blog/uploads/2012/02/201202_memory7.jpg" alt="" title="201202_memory7" width="600" height="480" class="alignnone size-full wp-image-909" srcset="/blog/uploads/2012/02/201202_memory7.jpg 600w, /blog/uploads/2012/02/201202_memory7-300x240.jpg 300w, /blog/uploads/2012/02/201202_memory7-375x300.jpg 375w" sizes="(max-width: 600px) 100vw, 600px" />][11]
  
「References to this object」にリンクが入っていると、メモリにインスタンスが残っている。このActivityはDestoryされていた。GCで回収されないといけないはずなのに、メモリに残っている。
  
逆に、実行中のクラスは表示されるのが正常である。Activityは画面上から消えていても、実行中の状態であることが多いので注意が必要。

メモリに残っているという事は、参照が残っているということ。どこから参照されているのかが問題となる。そういう時は、すぐ下にある「excludes weak refs」のリンクをクリック。
  
[<img src="/blog/uploads/2012/02/201202_memory8.jpg" alt="" title="201202_memory8" width="600" height="454" class="alignnone size-full wp-image-910" srcset="/blog/uploads/2012/02/201202_memory8.jpg 600w, /blog/uploads/2012/02/201202_memory8-300x227.jpg 300w, /blog/uploads/2012/02/201202_memory8-396x300.jpg 396w" sizes="(max-width: 600px) 100vw, 600px" />][12]
  
今回は、「net.eikatou.ib.frame.ChoiceAction.installedAppSyncTask」のフィールド「activity」に参照が残っていた。

Javaのソースコードを変更して、activityの保持を止めたら、GCで回収されるようになった。

今回はActivityを確認したが、Activityで保持しているインスタンスが回収されていることを確認するのも良いだろう。例えば、「Activityでimageを保持している。Activity#onStopでimageの参照を破棄する。その後のGCで、imageのインスタンスが回収されていることを確認する。」といった具合に。

# ポイント

以下のリンクを参考。注意して実装しましょう。

  * [Avoiding memory leaks &#8211; Android Developers Blog][13]
  * [Avoiding memory leaks （超訳） &#8211; Android Zaurusの日記][14]

## Contextに注意

よく引っかかるのが、以下のようなソースコード。
  
[java]
  
new ArrayAdapter<String>(Activity.this, android.R.layout.simple);

[/java]
  
これは、ArrayAdapterの第1引数のContextに、自分のクラスを渡している。ArrayAdapterは、このContextを保持してしまうため、参照が残り続ける。
  
[java]
  
new ArrayAdapter<String>(getApplicationContext(), android.R.layout.simple);

[/java]
  
getApplicationContext()を使うようにすると良い。 

ついついContextを持ち回ってしまうため、あちこちに参照が残る事となる。Contextは要注意だと覚えておくと良い。

# 参考

  * [Memory Analysis for Android Applications][1]
  * [メモリリークを発見！Androidアプリのメモリ解析手法][2]
  * [メモリリークを発見！Androidアプリのメモリ解析手法　その２ OQL (Object Query Language)利用方法][15]
  * [ImageViewとBitmap#recycle覚書][16]

 [1]: http://android-developers.blogspot.com/2011/03/memory-analysis-for-android.html
 [2]: http://andbrowser.com/development/knowhow/65/eclipse-android-memory-leak-mat/
 [3]: /blog/uploads/2012/02/201202_memory1.jpg
 [4]: /blog/uploads/2012/02/201202_memory2.jpg
 [5]: /blog/uploads/2012/02/201202_memory3.jpg
 [6]: /blog/uploads/2012/02/201202_memory4.jpg
 [7]: http://developer.android.com/guide/developing/tools/hprof-conv.html
 [8]: http://java.sun.com/javase/ja/6/docs/ja/technotes/tools/share/jhat.html
 [9]: /blog/uploads/2012/02/201202_memory5.jpg
 [10]: /blog/uploads/2012/02/201202_memory6.jpg
 [11]: /blog/uploads/2012/02/201202_memory7.jpg
 [12]: /blog/uploads/2012/02/201202_memory8.jpg
 [13]: http://android-developers.blogspot.com/2009/01/avoiding-memory-leaks.html
 [14]: http://d.hatena.ne.jp/androidzaurus/20090121
 [15]: http://andbrowser.com/development/knowhow/289/eclipse-android-memory-leak-mat-oql/
 [16]: http://d.hatena.ne.jp/hidecheck/20110625/1309024778
