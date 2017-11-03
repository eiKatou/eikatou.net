---
title: "読書：Java本格入門"
date: 2017-11-03T09:00:00+09:00
author: eiKatou
type: post
url: /20171103.html
archives:
  - 2017
tags:
  - Dev
  - Java
  - 読書
---

<a href="https://www.amazon.co.jp/Java%E6%9C%AC%E6%A0%BC%E5%85%A5%E9%96%80-%E3%83%A2%E3%83%80%E3%83%B3%E3%82%B9%E3%82%BF%E3%82%A4%E3%83%AB%E3%81%AB%E3%82%88%E3%82%8B%E5%9F%BA%E7%A4%8E%E3%81%8B%E3%82%89%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E6%8C%87%E5%90%91-%E5%AE%9F%E7%94%A8%E3%83%A9%E3%82%A4%E3%83%96%E3%83%A9%E3%83%AA%E3%81%BE%E3%81%A7-%E8%B0%B7%E6%9C%AC-%E5%BF%83-ebook/dp/B071D8RYR5/ref=as_li_ss_il?_encoding=UTF8&qid=&sr=&linkCode=li3&tag=eikatou-22&linkId=545cb44662b24acb073dd859140b8f97" target="_blank"><img border="0" src="//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B071D8RYR5&Format=_SL250_&ID=AsinImage&MarketPlace=JP&ServiceVersion=20070822&WS=1&tag=eikatou-22" ></a><img src="https://ir-jp.amazon-adsystem.com/e/ir?t=eikatou-22&l=li3&o=9&a=B071D8RYR5" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />

[Java本格入門｜Amazon](http://amzn.to/2lEFt8j)  
[Java本格入門｜技術評論社](http://gihyo.jp/book/2017/978-4-7741-8909-3)

少し前に話題になったJava本。「Javaを使ってきたけど、最新のJavaのトレンドを抑えたい」という気持ちで購入した。非常に役に立つ本だった。

コレクションの使い方から、マルチスレッド時の注意事項、Apache Commonsなどのライブラリの事まで、幅広く記載されている。幅広いけど実戦で使える内容に絞られている。短時間で役に立つ知識が身につけられる一冊。

自分の知識が増えたと思う内容をまとめておく。

<!--more-->


# プリミティブ型

プリミティブ型からラッパークラスに変換するときは、valueOfメソッドを使う。-127から128の範囲であれば、事前にオブジェクトが生成済みで、新規にオブジェクトを生成することがなく効率的。

いつも、IntegerとintとStringの変換メソッドが思い出せないので、以下にまとめておく。

```java
// StringとIntegerの変換
Integer num = Integer.valueOf("1");
String str = num.toString();

// Integerとintの変換
Integer num = Integer.valueOf(2);
int i = num.intValue();

// intとStringの変換
int i = Integer.parseInt("3");
String str = String.valueOf(i)
```

# 配列の初期化

配列の初期化方法は3パターン。

```java
// 宣言時に内容が決まっていないとき
int[] array1 = new int[ 10];
// 宣言時時に内容が決まっているとき
int[] array2 = { 1, 2, 3, 4, 5 };
// 宣言時時に内容が決まっているとき
int[] array3 = new int[] { 10, 9, 8, 7, 6 };
```

配列のコピーには、Arrays.copyOfメソッドが使える。

# コレクション

コレクションクラスのところでは、使い所がまとめられている。まとめがあると分かりやすいし、なぜこういう使い分けをするべきかも書かれている。

>・配列の途中で要素の追加や削除をおこなうことが多い  
>→　LinkedList  
>・for文などを使った全体的な繰り返し処理が多い  
>→　ArrayList  
>・複数スレッドから同時にアクセスする  
>→　CopyOnWriteArrayList

>・キーの大小を意識した部分集合を取り扱う場合  
>→　TreeMap  
>・要素の順序を保持する必要がある場合  
>→　LinkedHashMap  
>・複数スレッドから同時にアクセスする場合  
>→　ConcurrentHashMap  
>・その他の場合  
>→　HashMap  

# マルチスレッド

マルチスレッドのところでは、以下のような注意事項があったり・・。どう対応するのかも書かれている。

>HashMapに対して複数のスレッドから同時にアクセスする場合は、次のような対処が必要になります。  
>・複数のスレッドから同時にアクセスできないように、synchronizedなどにより同期化する  
>・複数のスレッドからアクセスされても安全に使えるConcurrentHashMapを使用する

# ユーティリティクラス

ユーティリティクラスはstaticメソッドにしない。利用する側のクラスに、staticインスタンスで持たせる方法があるという話し。テストの時にモック化できない問題は分かるけど、利用側クラスでstaticインスタンスにしてくれるか心配。自分はIoCコンテナに登録している。

>全てのメソッドをstaticとする、ユーティリティクラスを作成することがよくあります。ユーティリティクラスのメソッドがすべてstaticである理由は、インスタンス生成の無駄を省くことにあります。ユーティリティクラスを毎回newしてメソッドを呼び出すよりも、直接メソッドを呼び出したほうが効率的だからです。

>ただし、staticメソッドばかりでは拡張性がなく、またテストをおこなう際にメソッドをモック化できないため、筆者は普段、ユーティリティクラス自体は非staticメソッドで構成して、インスタンスをstaticにする手法を採用しています。

# ログ出力

ログの出力のところでは、このような問題があることが記載されている。

>その際、次に示すように記述してしまうと、パフォーマンスが悪くなってしまう可能性があります。  
>logger.debug("employee="+employee+",department="+department);

>アプリケーションのログレベルがINFOで動作していた場合、DEBUGレベルのログは出力されません。しかし、その出力レベルの判定は、ライブラリの中でおこなわれます。上記のコードでは、ライブラリの中に入る前に、employeeオブジェクトとdepartmentオブジェクトのtoStringメソッドを実行することになり、toStringメソッドの処理が重いために、アプリケーションのパフォーマンスも悪くなってしまいます。

これは、少し前に仕事で問題となったところだった。SL4Jではこの問題は解決されていて、プレースホルダーを利用することで、ライブラリ内でtoStringメソッドが実行されるようになっているとのこと。つまり、INFOで動作しているときはdebugメソッド内のtoStringメソッドは呼ばれずに、パフォーマンスが悪くなることがない。

---
<div class="amazlet-box" style="margin-bottom:0px;"><div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B071D8RYR5/eikatou-22/ref=nosim/" name="amazletlink" target="_blank"><img src="https://images-fe.ssl-images-amazon.com/images/I/51BIaJT2TKL._SL160_.jpg" alt="Java本格入門 ～モダンスタイルによる基礎からオブジェクト指向・実用ライブラリまで" style="border: none;" /></a></div><div class="amazlet-info" style="line-height:120%; margin-bottom: 10px"><div class="amazlet-name" style="margin-bottom:10px;line-height:120%"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B071D8RYR5/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">Java本格入門 ～モダンスタイルによる基礎からオブジェクト指向・実用ライブラリまで</a><div class="amazlet-powered-date" style="font-size:80%;margin-top:5px;line-height:120%">posted with <a href="http://www.amazlet.com/" title="amazlet" target="_blank">amazlet</a> at 17.11.01</div></div><div class="amazlet-detail">技術評論社 (2017-04-18)<br />売り上げランキング: 20,973<br /></div><div class="amazlet-sub-info" style="float: left;"><div class="amazlet-link" style="margin-top: 5px"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B071D8RYR5/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a></div></div></div><div class="amazlet-footer" style="clear: left"></div></div>