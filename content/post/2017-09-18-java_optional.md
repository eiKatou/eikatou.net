---
archives:
- 2017
author: eiKatou
date: 2017-09-18T06:48:04+09:00
tags:
- Dev
- Java
title: "Java8入門：Optionalの使い方・使い所"
type: post
url: /20170918.html
---

![Java Logo](/uploads/logo/java.png)

Java 6以降、Javaの勉強をサボっていたので、Java7とJava8を勉強している。今回は、Optionalの使い方・使い所を学んだ。

<!--more-->

Optionalは、Null か 値のどちらかが入っているクラスである。Nullオブジェクトパターンと似ているなと感じた。

# 使い方

Optionalを生成するメソッド。普通はofNullableを使うんだろうと思う。

| メソッド名 | 説明 |
| ------- | ------- |
| empty() | 空のOptional |
| ofNullable(T value) | Nullを許容するOptional |
| of(T value) | Nullを許容しないOptional |

値を取得するメソッド。orElseをメインで使っていく。

| メソッド名 | 説明 |
| ------- | ------- |
| get() | 保持している値を返す。値がなければ例外が発生 |
| orElse(T value) | 保持している値を返す。値がなければ引数の値を返す |
| orElseGet(Supplier<? extends T> other) | 保持している値を返す。値がなければラムダ式で生成した値を返す |

その他のメソッド。

| メソッド名 | 説明 |
| ------- | ------- |
| isPresent() | 説明値を保持しているかどうか |
| ifPresent(Consumer<? super T> consumer) | 値を保持しているときのみ引数のラムダ式を実行 |
| filter(Predicate<? super T> predicate) | 条件に合致した場合のみ値を返す |
| map(Function<? super T,? extends U> mapper) | 値を保持している場合のみ値を処理する |
| flatMap(Function<? super T,Optional<U>> mapper) | 値の返還と平坦化を行う |

参考リンク

- [Optional (Java Platform SE 8 )](https://docs.oracle.com/javase/jp/8/docs/api/java/util/Optional.html)
- [Java8のOptionalの使い方について - TASK NOTES](http://www.task-notes.com/entry/20150708/1436324400)

## サンプルソース その1
```java
public static void sample1() {
//int[] numbers = {1, 2, 3};
  int[] numbers = {};
  OptionalDouble aveOption = Arrays.stream(numbers).average();
  double average = aveOption.orElse(0);
  if (aveOption.isPresent()) {
    System.out.println("値が存在します。");
  } else {
    System.out.println("値が存在しません。");
  }
  System.out.println("average = " + average);
}
```

## 実行結果

    sample1
    値が存在しません。
    average = 0.0

## サンプルソース その2
```java
public static void sample2() {
  Optional<String> op = Optional.empty();
  // 値が存在する場合のみ出力する
  op.ifPresent(s -> System.out.println(s));

  Optional<String> op2 = Optional.ofNullable("ofNullable method.");
  // 値が存在する場合のみ出力する
  op2.ifPresent(s -> System.out.println(s));

  Optional<String> op3 = Optional.ofNullable(null);
  // 値が存在する場合のみ出力する
  op3.ifPresent(s -> System.out.println(s));

  // nullを入れるとヌルポ
  //Optional<String> op4 = Optional.of(null);
  Optional<String> op4 = Optional.of("of method.");
  // 値が存在する場合のみ出力する
  op4.ifPresent(s -> System.out.println(s));
}
```

## 実行結果

    sample2
    ofNullable method.
    of method.

# 使い所
思いつく感じだと以下の2点かな。

- メソッドの戻り値
- Nullチェックで、処理を切り分けているところ

Scalaを読める人向けだけど、以下の記事も参考になる。  
[ScalaのOptionステキさについてアツく語ってみる - ( ꒪⌓꒪) ゆるよろ日記](http://yuroyoro.hatenablog.com/entry/20100710/1278763193)

今までJavaDocでしか、メソッドの戻り値にnullが入ることを知らせることができなかった。例えばHashMapのgetメソッドなど。そこをOptionにすることで、メソッドの利用者にnullが入る可能性を知らせることができる。

値がない可能性があるところがOptionになっていれば、mapやflatmapを使って、if文を書かずに処理を継続できる。Streamクラスと一緒に使えば、非常に便利に使うことができそうだ。

今回のサンプルソース  
[Sample/Main.java at master · eiKatou/Sample](https://github.com/eiKatou/Sample/blob/master/Java/Eclipse/Java7and8/src/optional/Main.java)