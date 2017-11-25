---
title: "Java8入門：Stream API"
date: 2017-11-25T10:00:00+09:00
author: eiKatou
type: post
url: /20171125.html
archives:
  - 2017
tags:
  - Dev
  - Java
---

![Java Logo](/uploads/logo/java.png)

Java8で追加されたStream API。いよいよ本丸である。

<!--more-->

# Stream APIの特徴
[Java8入門：Lambda式](/20171018.html)で書いたように、並列処理を簡単に行えるようにする目的がある。単なる繰り返し処理を行う方法ではないのだ。

StreamAPIを利用することで以下のメリットがある。

- 繰り返し処理を分かりやすく記述できる
- 並列処理を簡単に導入できる

Streamは生成処理・中間処理・終端操作の3段階がある。生成処理でStreamを生成し、中間処理はStreamのデータの絞り込みや変換を行い、終端操作で結果を取り出す。

また、Streamには以下の特徴がある。

- 終端操作を行ったタイミングで、遡って中間処理が実行される
- 終端処理を行ったストリームの再利用はできない

# 使い方
[Stream (Java Platform SE 8 )](https://docs.oracle.com/javase/jp/8/docs/api/java/util/stream/Stream.html)

生成処理・中間処理・終端操作で使えるメソッドは、[Java Streamメモ(Hishidama's Java8 Stream Memo)](http://www.ne.jp/asahi/hishidama/home/tech/java/stream.html)に良い感じにまとまっている。

# GroupingByメソッド
groupbyメソッドが使えそうである。リストの中にある要素を、特定の条件で集約することができる。

[Sample/StreamGrouping.java](https://github.com/eiKatou/Sample/blob/master/Java/Eclipse/Java7and8/src/stream/StreamGrouping.java)

```java
Map<String, List<Person>> personGroupAByCity = groupA.stream()
    .collect(Collectors.groupingBy(p -> p.city));
```

集約条件を複数にすることもできる。以下のコードでは、cityで集約した後、年齢で集約している。
```java
Map<Object, Map<Object, List<Person>>> personGroupBByCity = 
    groupB.stream()
      .collect(Collectors.groupingBy(p -> p.city, 
        Collectors.groupingBy(p -> p.age)));
```


データを処理した後、特定の条件で集約して、オブジェクトに変換するといった流れになるだろう。ただ、、Mapのメソッドが弱すぎて、Mapを処理するのがめんどくさい・・。2つのMapを結合したりできないのだろうか。。

# パラレルストリーム
並列処理にするには、parallelメソッドを挟むだけ。これでマルチコアを生かした処理が書けるのだから、本当にありがい機能である。

```java
// 並列処理しない
IntStream.range(0, 100)
  .forEach(System.out::println);

// 並列処理する
IntStream.range(0, 100)
  .parallel()
  .forEach(System.out::println);
```

ただし、処理が複数に分かれるため、結果は順番に並ばない。順番を意識するような処理には使えない。

その他、いろいろな注意点があり、以下のことを気をつけて実装を行う。

- ストリームのサイズによっては、オーバーヘッドの方が大きくなる
- ストリームの処理内では例外を発生させないようにする
- 外部変数へアクセスしないようにする

# 2つのStreamを結合する
[Java8のStreamを使いこなす - きしだのはてな](http://d.hatena.ne.jp/nowokay/20130504)の「zipでふたつのStreamを統合する」を見ると、Java8にzipメソッドはないようだ。

例えば、ファイルを読み込んで特定の文字列がある行を抽出し、行番号とその行を出力したいときに、zipメソッドは使える。行番号Streamと行データStreamを結合できれば、行番号とデータが一緒になるので、順番に処理しなくても良い。つまり、並列で処理できるようになる。

2つのデータを結合すると、2つのデータを一緒に扱いたくなる。ScalaでいうとToupleが欲しい、と思っていたら、以下の記事を見つけた。

- [Java8で必須のPairとzip - きしだのはてな](http://d.hatena.ne.jp/nowokay/20140321)
- [JavaでTupleが欲しくなったときメモ - Qiita](https://qiita.com/disc99/items/738fb328b22c05900b8a)


[Commons Lang](https://commons.apache.org/proper/commons-lang/)のPairクラスとzipメソッドを使って、特定の文字列を含む行を取り出す。こんな感じのソースコードになる。

[Sample/PairSample.java](https://github.com/eiKatou/Sample/blob/master/Java/Eclipse/Java7and8/src/stream/PairSample.java)

```java
Path path = Paths.get("RFC_HTTP.txt");
try (Stream<String> lines = Files.lines(path)) {
  Stream<Integer> lineNums = IntStream.iterate(1, n -> n+1).boxed();
  zip(lineNums, lines)
    .parallel()
    .filter(p -> p.getRight().contains("HTTP"))
    .forEach(p -> System.out.println(p.getLeft() + "行目：" + p.getRight()));
}
```

# どう使うか？
繰り返し処理を使っているところの置き換えがメインになるだろう。並列化できるところはparalle()を使っていく。より分かりやすく記述することができるようになった。

# 参考
Java7/8を勉強するのにおすすめの本。  
今回も参考にさせていただいた。

<div class="amazlet-box" style="margin-bottom:0px;"><div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774177385/eikatou-22/ref=nosim/" name="amazletlink" target="_blank"><img src="https://images-fe.ssl-images-amazon.com/images/I/51ItVl5Qr2L._SL160_.jpg" alt="現場で使える[最新]Java SE 7/8 速攻入門" style="border: none;" /></a></div><div class="amazlet-info" style="line-height:120%; margin-bottom: 10px"><div class="amazlet-name" style="margin-bottom:10px;line-height:120%"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774177385/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">現場で使える[最新]Java SE 7/8 速攻入門</a><div class="amazlet-powered-date" style="font-size:80%;margin-top:5px;line-height:120%">posted with <a href="http://www.amazlet.com/" title="amazlet" target="_blank">amazlet</a> at 17.10.01</div></div><div class="amazlet-detail">櫻庭 祐一 <br />技術評論社 <br />売り上げランキング: 467,147<br /></div><div class="amazlet-sub-info" style="float: left;"><div class="amazlet-link" style="margin-top: 5px"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774177385/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a></div></div></div><div class="amazlet-footer" style="clear: left"></div></div>