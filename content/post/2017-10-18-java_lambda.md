---
title: "Java8入門：Lambda式"
date: 2017-10-18T04:42:25+09:00
author: eiKatou
type: post
url: /20171018.html
archives:
  - 2017
tags:
  - Dev
  - Java
---

![Java Logo](/uploads/logo/java.png)

Java8で追加されたLambda式。Lambda式のおかげで、匿名クラスを簡単に表現できるようになった。

<!--more-->

# Lambda式の目的
Java8ではStream APIの導入により、内部イテレータの繰り返し処理が

[Java SE 7／8 速攻入門](http://amzn.to/2yniBPS)の本には、以下のように記載されている。

>内部イテレータを使用したデータ処理を行うライブラリとして導入されたStream APIです。Stream APIを使用することで内部イテレータを記述した処理を簡単にパラレル化することができます。

>内部イテレータの繰り返し行う処理を関数やクロージャなどで表します。関数などで表すことにより、外部イテレータで記述するよりも処理の独立性を高めることができ、パラレル処理への移行を容易に行うことができます。

Javaでは匿名クラスを使って内部イテレータの処理を表している。しかし、匿名クラスを使うと処理の記述量が増えてしまう。そのため、匿名クラスを簡単に表現できるようにしたものがLambda式とのこと。

Lambda式は、Stream APIとセットで使っていくイメージである。

# 関数型インターフェース
関数型インターフェースは、実装すべきメソッドが1つのインターフェースのことである（defaultメソッドとstaticメソッドは除く）。標準では、以下のインターフェースがある。

[java.util.function (Java Platform SE 8 )](https://docs.oracle.com/javase/jp/8/docs/api/java/util/function/package-summary.html)

| クラス名 | 説明 |
| ------- | ------- |
|Function<T,R>|1つの引数を受け取って、結果を生成する|
|Consumer<T>|1つの入力引数を受け取って、結果を返さない|
|Consumer<T>|1つの入力引数を受け取って、booleanを返す|
|Supplier<T>|入力引数はなく、結果を生成する|

上の表は代表的なクラス。他にも大量のクラスあるけど、引数の数と戻り値の有無でパターンが増えているだけである。JavaDocをみると、defaultメソッドとstaticメソッドを除くと、1つしかメソッドが定義されていない。なので、これらは関数型インターフェースである。

Java8ではインターフェースにメソッド実装を持てるようになった。defaultメソッドとstaticメソッドである。過去との互換性を保ちながら機能拡張させるために、このような形となったようだ。実装を持てるのはイマイチだなと思う。積極的に使っていく機能ではない。

自分で関数型インターフェースを作成するときは、@FunctionalInterfaceアノテーションをつけて、メソッドが1つのインターフェースを作れば良い。こんな感じ。

[Sample/FunctionalInterfaceSample.java at master · eiKatou/Sample](https://github.com/eiKatou/Sample/blob/master/Java/Eclipse/Java7and8/src/lambda/FunctionalInterfaceSample.java)

```java
public static void main(String[] args) {
  MyFunction<Integer, Integer, String> myFunc1
    = (x, y) -> String.format("myFunc1:%s,%s", x.toString(), y.toString());
  System.out.println(myFunc1.exec(101, 102));
}

@FunctionalInterface
interface MyFunction<S, T, R> {
  R exec(S s, T t);
}
```

# Lambda式の書き方
引数が1つのとき、以下のように書くことができる。

    x -> 実行処理;

匿名クラスから省略していって、この形になっていく経緯を理解しておく。

[Sample/FaunctionSample.java at master · eiKatou/Sample](https://github.com/eiKatou/Sample/blob/master/Java/Eclipse/Java7and8/src/lambda/FaunctionSample.java)

```java
// 通常の匿名クラスの記述
Function<Integer, String> func1 = new Function<Integer, String>() {
  @Override
  public String apply(Integer t) {
    return "func1:" + t.toString();
  }
};
System.out.println(func1.apply(101));

// Lambda式での記述
Function<Integer, String> func2 = (Integer x) -> {
  return "func2:" + x.toString();
};
System.out.println(func2.apply(102));

// 型推論でIntegerを省略可能
Function<Integer, String> func3 = (x) -> {
  return "func3:" + x.toString();
};
System.out.println(func3.apply(103));

// 引数が1つの時は丸カッコを省略可能
Function<Integer, String> func4 = x -> {
  return "func4:" + x.toString();
};
System.out.println(func4.apply(104));

// 実行文が1つの時は波カッコを省略可能
Function<Integer, String> func5 = x -> "func5:" + (x).toString();
System.out.println(func5.apply(105));
```

引数がないときは、以下のように書く。
```java
// 引数がないとき
Supplier<String> func6 = () -> "func6:test";
System.out.println(func6.get());
```

引数が2つ以上あるときは、以下のように書く。
```java
// 引数が2つあるとき
BiFunction<Integer, Integer, String> func7
  = (x, y) -> "func7:" + String.valueOf(x.intValue() + y.intValue());
System.out.println(func7.apply(5, 13));
```


# 関数合成
関数合成で2つの関数を合体できる。1つ目の関数の戻り値の型と、2つ目の関数の引数の型が一致していないといけないようだ。

```java
// andThenで合成関数を作る
Function<Integer, Integer> funcPlus = x -> x+100;
Function<Integer, String> funcPrint = x -> "funcPrint:" + (x).toString();
Function<Integer, String> funcPlusPrint = funcPlus.andThen(funcPrint);
System.out.println(funcPlusPrint.apply(500));

// composeで合成関数を作る
System.out.println(funcPrint.compose(funcPlus).apply(600));
```

funcPlusの戻り値がIntegerなので、funcPrintはIntegerを引数に取っている。

# メソッド参照
Lambda式を書かずに、メソッド名だけを記述することができる。staticメソッドの場合は下記の書き方となる。ドットではなくコロンを使用する。

    System.out::println

インスタンスメソッドの場合はobject::methodの形になる。コンストラクタもメソッド参照で書くことができる。

[Sample/MethodReferenceSample.java at master · eiKatou/Sample](https://github.com/eiKatou/Sample/blob/master/Java/Eclipse/Java7and8/src/lambda/MethodReferenceSample.java)

```java
// インスタンスメソッド参照
List<String> list = new ArrayList<>();
Consumer<String> addListFunc1 = list::add;
addListFunc1.accept("aaa");

// コンストラクタ参照
IntFunction<String[]> arrayFunc2 = String[]::new;
String[] array2 = arrayFunc2.apply(13);
```


# 参考
Java7/8を勉強するのにおすすめの本。  
今回も参考にさせていただいた。

<div class="amazlet-box" style="margin-bottom:0px;"><div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774177385/eikatou-22/ref=nosim/" name="amazletlink" target="_blank"><img src="https://images-fe.ssl-images-amazon.com/images/I/51ItVl5Qr2L._SL160_.jpg" alt="現場で使える[最新]Java SE 7/8 速攻入門" style="border: none;" /></a></div><div class="amazlet-info" style="line-height:120%; margin-bottom: 10px"><div class="amazlet-name" style="margin-bottom:10px;line-height:120%"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774177385/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">現場で使える[最新]Java SE 7/8 速攻入門</a><div class="amazlet-powered-date" style="font-size:80%;margin-top:5px;line-height:120%">posted with <a href="http://www.amazlet.com/" title="amazlet" target="_blank">amazlet</a> at 17.10.01</div></div><div class="amazlet-detail">櫻庭 祐一 <br />技術評論社 <br />売り上げランキング: 467,147<br /></div><div class="amazlet-sub-info" style="float: left;"><div class="amazlet-link" style="margin-top: 5px"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774177385/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a></div></div></div><div class="amazlet-footer" style="clear: left"></div></div>


以下のスライドも非常に参考になった。  
<iframe src="//www.slideshare.net/slideshow/embed_code/key/3twj1P11D8Bzzu" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe> <div style="margin-bottom:5px"> <strong> <a href="//www.slideshare.net/zoetrope/java8-lambdaandstream" title="社内Java8勉強会 ラムダ式とストリームAPI" target="_blank">社内Java8勉強会 ラムダ式とストリームAPI</a> </strong> from <strong><a href="//www.slideshare.net/zoetrope" target="_blank">Akihiro Ikezoe</a></strong> </div>
