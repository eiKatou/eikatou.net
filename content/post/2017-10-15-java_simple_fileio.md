---
title: "Java8入門：簡単なファイル入出力"
date: 2017-10-15T17:21:38+09:00
author: eiKatou
type: post
url: /20171015.html
archives:
  - 2017
tags:
  - Dev
  - Java
---

![Java Logo](/uploads/logo/java.png)

[前回](20171012.html)のNIO.2の続きで、簡単にファイル入出力ができるようになったので試してみた。

<!--more-->

サンプルコードは、以下に置いている。  
[Sample/SimpleReadWrite.java at master · eiKatou/Sample](https://github.com/eiKatou/Sample/blob/master/Java/Eclipse/Java7and8/src/nio2/SimpleReadWrite.java)

JavaDocは以下。  
[Files (Java Platform SE 8 )](https://docs.oracle.com/javase/jp/8/docs/api/index.html?java/nio/file/Files.html)

# BufferedReader, BufferedWriterを使う
ファイルの入出力で使うBufferedReader, BufferedWriterは、Filesクラスから取得できるようになった。

```java
try (BufferedReader reader = Files.newBufferedReader(fooPath)) {
  String line = null;
  while ((line = reader.readLine()) != null) {
    System.out.println(line);
  }
}

try (BufferedWriter writer = Files.newBufferedWriter(fooPath)) {
  writer.append("abc");
  writer.newLine();
  writer.append("def");
  writer.newLine();
}
```

上記のサンプルでは、try-with-resouces文で自動でクローズしている。Exceptionは上に投げているので、あえてcatchしていない。今までに比べてシンプルに書けるようになった。

# Filesクラスのメソッドを使う
Filesクラスのメソッドを使う方法もある。

## ファイル書き込み
リストで文字列を持っておき、ファイルに書き込む。

```java
List<String> lines = Stream.of("123", "ccc").collect(Collectors.toList());
Files.write(fooPath, lines, CREATE, WRITE, APPEND);
```
writeメソッドの第3引数以降は、java.nio.file.StandardOpenOptionの定数を渡す。static importしておくのがおすすめ。

## ファイルの読み込み
ファイルの読み込みは、readAllLinesとlinesの2つのメソッドがある。どちらもファイルを読み込んで、Streamで返してくれる。

```java
// ファイルの読み込み（Close処理は不要）
Files.readAllLines(fooPath).forEach(System.out::println);

// ファイルの読み込み（Close処理が必要！）
try (Stream<String> fileLines = Files.lines(fooPath)) {
  fileLines.forEach(System.out::println);
}
```

readAllLinesは、ファイル内容を全てメモリに保持するため、大きなファイルの読み込みは使わない方がいい。

linesはクローズ処理が必要である（忘れそう・・）。これからはFiles.linesメソッドを中心に使っていくことになるだろう。

文字コードを指定することができるメソッドは、可能な限り文字コードを指定しておいた方が良い。
