---
title: "Java8入門：日付関係知識とDate and Time API"
author: eiKatou
date: 2017-10-01T14:34:14+09:00
type: post
url: /20171001.html
archives:
  - 2017
tags:
  - Dev
  - Java
---

![Java Logo](/uploads/logo/java.png)

Java7とJava8を勉強で、日付関係APIを学んだ。APIも重要だが、ISO 8601という日時表現の国際標準規格や、世界共通時（UTC）の内容も学んだ。

<!--more-->

# 日付関係知識
UTCとGMTの違いは？、UNIX時間とは？など、日付関係は知識を整理しておく。

## ISO 8601とは
ISO 8601は日付と時刻の表記に関する国際規格である。世界共通時（UTC）とグレゴリオ暦を基準として利用する。JavaのDate and Time APIは、ISO8601をベースとしている。

今、このブログを書いている時間を表現すると、以下のような表記となる。  
2017-10-01T14:09:42+09:00

UTC時で表示すると、以下のようになる。  
2017-10-01T05:09:42Z


[ISO 8601 - Wikipedia](https://ja.wikipedia.org/wiki/ISO_8601)

    ISO 8601は日付と時刻の表記に関する国際規格。最新版は2004年に発行されたISO 8601:2004 で、古い版としてISO 8601:2000 、ISO 8601:1988 があった。

## 世界共通時（UTC）とは
今の標準時はUTCだと覚えておく。GMT グリニッジ標準時は、過去に使われていた標準時。

[UTC協定世界時とGMTグリニッジ標準時の違い | LOCALTIME.JP](https://www.localtime.jp/utc-gmt/)

    世界共通の標準時であり、セシウム原子時計によって刻まれる国際原子時をもとにして常に正確に保持されている。


## グレゴリオ暦とは
グレゴリオ暦は日本でも使われている。暦とは、年や月などの区切りを決めるためのルールだと理解した。太陽暦は、地球が太陽の周りを1周する期間を1年としている。

[グレゴリオ暦 - Wikipedia](https://ja.wikipedia.org/wiki/%E3%82%B0%E3%83%AC%E3%82%B4%E3%83%AA%E3%82%AA%E6%9A%A6)

    現行太陽暦として世界各国で用いられている。（一部省略）紀年法はキリスト紀元（西暦）を用いる。

[太陽暦 - Wikipedia](https://ja.wikipedia.org/wiki/%E5%A4%AA%E9%99%BD%E6%9A%A6)

    太陽暦（たいようれき、英: solar calendar）とは、地球が太陽の周りを回る周期（太陽年）を基にして作られた暦（暦法）である。1年の日数を1太陽年に近似させている。ユリウス暦や、現在、世界の多くの地域で使用されているグレゴリオ暦は、太陽暦の1種である。

[太陰暦 - Wikipedia](https://ja.wikipedia.org/wiki/%E5%A4%AA%E9%99%B0%E6%9A%A6)

    太陰暦（たいいんれき、英: lunar calendar、亜: تقويم قمري‎）は、月の満ち欠けの周期を基にした暦（暦法）である。

## 西暦とは
西暦とは何か？という疑問が出てきた。西暦 2017年というので、日本では西暦を使っているのではないか？と思った。Wikipedia先生に教えてもらう。


[西暦 - Wikipedia](https://ja.wikipedia.org/wiki/%E8%A5%BF%E6%9A%A6)

    イエス・キリストが生まれたとされる年の翌年を元年（紀元）とした紀年法である。

[紀年法 - Wikipedia](https://ja.wikipedia.org/wiki/%E7%B4%80%E5%B9%B4%E6%B3%95)

    紀年法（きねんぽう）とは、年を数えたり、記録する方法をいう

西暦は年の数え方を示しているだけで、1年を定義するものではないということが分かった。

1年の長さはグレゴリオ暦で定義しており、西暦はイエス・キリストが生まれた年から数えるという決まりを表している。”暦”という単語がややこしい。


## UNIX時間とは
コンピュータ関係の人なら知っているが、1970年1月1日0時0分0秒からの経過時間である。今までのJavaのDateクラスやCalendarクラスは、UNIX時間をベースとして作られていた。

[UNIX時間 - Wikipedia](https://ja.wikipedia.org/wiki/UNIX%E6%99%82%E9%96%93)

    コンピューターシステム上での時刻表現の一種。UNIXエポック、すなわち協定世界時 (UTC) での1970年1月1日真夜中（午前0時0分0秒）の時刻からの形式的な経過秒数（すなわち、実質的な経過秒数から、その間に挿入された閏秒を引き、削除された閏秒を加えたもの）として表される。


# 日付関係API
ようやく基礎知識が身についた。Date and Time APIを触っていく。

## 利用するクラス
以下のクラスが中心的なクラスとなる。

| クラス名 | 説明 |
| ------- | ------- |
| LocalDateTime | 日付と時間を保持する |
| OffsetDateTime | 時差を考慮して日付と時間を保持する |
| ZonedDateTime | タイムゾーンを考慮して日付と時間を保持する |
| Duration | 時間間隔を表す |
| Period | 年月日で時間間隔を表す |


LocalDateTimeを中心に使いつつ、UTC時間や時差を考慮するようなシステムならばOffsetDateTimeを使う。夏時間の切り替えや地域間の時間差を扱う場合は、ZonedDateTimeを使う。

DateクラスやCalendarクラスに比べて、分かりやすくなったと思う。特にイミュータブルになった点が一番気に入った。

DateクラスやCalendarクラスを使っているシステムは、LocalDateTimeなどを混ぜずに今まで通りの方が良さそう。1から作るシステムは、新しいAPIを使っていくのが分かりやすいと思う。

## サンプルコード
[Sample/Main.java at master · eiKatou/Sample](https://github.com/eiKatou/Sample/blob/master/Java/Eclipse/Java7and8/src/datetime/Main.java)


インスタンスを生成する

    LocalDateTime.now();
    LocalDateTime.of(2017, Month.OCTOBER, 3, 15, 50);
    LocalDateTime.parse("2017-08-13T12:12:35");

年や月や時刻などを設定する

    localDateTime.withYear(1999);
    localDateTime.withMonth(3);

時刻を進めたり戻したりする

    localDateTime.plusYears(2);
    localDateTime.plusDays(3);
    localDateTime.minusDays(1);

日時をフォーマットして出力する  
アルファベット以外はシングルクォートで囲むこと。

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy'年'MM'月'dd'日 'HH'時'mm'分'ss'秒'");
    localDateTime.format(formatter)

日時間隔を扱う

    LocalDateTime.now().minus(Duration.ofHours(30))
    // 1年2ヶ月3日の間隔
    Period period1 = Period.of(1, 2, 3);
    LocalDateTime.now().plus(period1)

時差付きの日時を生成する

    OffsetDateTime.of(2017, 9, 5, 16, 24, 45, 500_000_000, ZoneOffset.of("+09:00"))


# 参考書籍
Java7/8を勉強するのにおすすめの本。  
今回も参考にさせていただいた。

<div class="amazlet-box" style="margin-bottom:0px;"><div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774177385/eikatou-22/ref=nosim/" name="amazletlink" target="_blank"><img src="https://images-fe.ssl-images-amazon.com/images/I/51ItVl5Qr2L._SL160_.jpg" alt="現場で使える[最新]Java SE 7/8 速攻入門" style="border: none;" /></a></div><div class="amazlet-info" style="line-height:120%; margin-bottom: 10px"><div class="amazlet-name" style="margin-bottom:10px;line-height:120%"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774177385/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">現場で使える[最新]Java SE 7/8 速攻入門</a><div class="amazlet-powered-date" style="font-size:80%;margin-top:5px;line-height:120%">posted with <a href="http://www.amazlet.com/" title="amazlet" target="_blank">amazlet</a> at 17.10.01</div></div><div class="amazlet-detail">櫻庭 祐一 <br />技術評論社 <br />売り上げランキング: 467,147<br /></div><div class="amazlet-sub-info" style="float: left;"><div class="amazlet-link" style="margin-top: 5px"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4774177385/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a></div></div></div><div class="amazlet-footer" style="clear: left"></div></div>


