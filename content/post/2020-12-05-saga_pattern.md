---
title: "分散トランザクション Sagaパターンを学ぶ"
date: 2020-12-05T09:25:33+09:00
author: eiKatou
type: post
url: /20201205.html
archives:
  - 2020
tags:
  - 読書
  - IT技術
---

<a href="https://www.amazon.co.jp/%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3-%E5%AE%9F%E8%B7%B5%E7%9A%84%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E3%83%87%E3%82%B6%E3%82%A4%E3%83%B3%E3%81%AE%E3%81%9F%E3%82%81%E3%81%AE%E3%82%B3%E3%83%BC%E3%83%89%E8%A7%A3%E8%AA%AC-impress-top-gear/dp/4295008583/ref=as_li_ss_il?ie=UTF8&linkCode=li3&tag=eikatou-22&linkId=2d635e27d372a88bffd91af2b7eb8eb6&language=ja_JP" target="_blank"><img border="0" src="//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=4295008583&Format=_SL250_&ID=AsinImage&MarketPlace=JP&ServiceVersion=20070822&WS=1&tag=eikatou-22&language=ja_JP" ></a>
- [マイクロサービスパターン 実践的システムデザインのためのコード解説 - Amazon](https://amzn.to/37wrEgU)
- [マイクロサービスパターン 実践的システムデザインのためのコード解説 - インプレスブックス](https://book.impress.co.jp/books/1118101063)

Sagaパターンについて、マイクロサービスパターン本とメリカリの事例から学んだ記録。

<!--more-->

# Sagaパターン

書籍「マイクロサービスパターン」からの引用

## Sagaの特徴

- 非同期メッセージングを利用したトランザクション管理
- ACD。原子性、整合性、持続性を保証する
- 分離性をサポートしない
- 分離性がないことによる並行処理の以上に対して対策する必要がある

## 分散トランザクションの問題点 p.124

ここでいう分散トランザクションとは[X/Open XA - Wikipedia](https://ja.wikipedia.org/wiki/X/Open_XA)のこと。

- 新しいテクノロジーはXAをサポートしていない（NoSQL DB, Kafkaなど）
- 同期IPCなので可能性が下がる

## Sagaを使ってデータ整合性を維持する方法

ポイントとなる考え方

- 並行処理への対策
- 保証トランザクションを使用する

## Sagaのコーディネート

オーケストレーションで良い。

- コレオグラフィベース
- オーケストレーション

### Sagaの構造

p.141だがここが適切。

- 補償可能トランザクション：補償トランザクションでロールバックされる可能性があるトランザクション
- ピボットトランザクション：処理を最後までするか、キャンセルするかの判断となるトランザクション
- 再試行可能トランザクション：ピボットトランザクションに続いて実行されるトランザクション。成功が保証されている。

## 分離性欠如への対策

Sagaのトランザクションが完了していなくても、各マイクロサービスのローカルトランザクションへのコミット結果が他サービスからも見えてしまう。DBでいうとダーティリードが発生する状態。

Sagaを並行実行したときの結果は、Sagaを直列実行した時の結果と異なる。

### どんな問題が起きるのか？

- 更新の消失：他のトランザクションがデータを上書きしてしまう
- ダーティリード：トランザクションが完了していないデータを他トランザクションや他サービスが読み取ってしまう
- ファジー/反復不能読み取り：トランザクション内で、違うタイミングでデータを読み取ったときに値が変わっている

ダーティリードの問題を解説している例が分かりやすい。

### Semantic lock

レコードにフラグを用意する。レコードがコミットされていなくて書き換えられる可能性があることを示す。これにより、レコードのロック管理を行う。

レコードがロックされている場合は、新たなトランザクションの受け入れを拒否することができる。書籍の例では、Order→OrderCancel。Orderのトランザクション中はOrderCancelを拒否する。

もしくは、新たなトランザクションを受け入れて、実行を待たせるということもできる。Orderのトランザクションが終わったら、OrderCancelを実行する。

### Commutative updates

更新操作を交換可能にする。どのような順序で実行しても良いものは交換可能。口座に対する入金と出金。お金の増減だけなので、更新前の状態に依存しない。

### Pessimistic view

ダーティーリードしないように、Sagaのステップを並び替える。ダーティーリードされたくないサービスは、補償トランザクションで値が変わってしまうステップから外す。再試行可能トランザクションにする。

### Reread value

更新結果の消失を防ぐ。値を更新する前に読み直して、値が変更されていない場合のみ更新する。値が変わっている場合は、Sagaを中止する。楽観的ロック制御と同じ。

### Version file

過去の操作履歴を持つことで、後からくる不正な操作を防ぐ。

書籍の例では、Cancel Authorizationを受け取った後は、Authorize Cardができないようにする。

### By value

ビジネスリスクに基づいて、利用する並行処理メカニズムを選択する。

書籍の例では、大きなお金を扱うようなハイリスクの場合にはXAトランザクションを使い、ローリスクの場合はSagaを使うという記載がある。

ハイリスクの場合は、可能性は下がってしまうが分離性が高い手法（XA）を使う。これならトラブル発生頻度が低くなる。

# メルカリでの事例
[マイクロサービスにおける決済トランザクション管理 | メルカリエンジニアリング](https://engineering.mercari.com/blog/entry/2019-06-07-155849/)が非常に参考になる。

ちょうど先日、[merpay Tech Talk ~ 決済基盤（Payment Platform）Backend裏話 - connpass](https://mercari.connpass.com/event/195066/)が開催されていた。youtubeに配信の動画が残っているので、後から見れる。以下のような話もあって、Sagaを実践するためのノウハウを話してくれていた。

> コアなところはSagaでやっている。失敗する処理は初めの方に。あとの方は失敗しない処理にしている。失敗しない処理はリトライする。Sagaの状態をDBにも永続化している。状態遷移のログを持っているので、開発環境で再現しやすい。（イベントソーシング的な？）

# TCCパターンとSagaパターン
[TCCパターンとSagaパターンでマイクロサービスのトランザクションをまとめてみた - Qiita](https://qiita.com/nk2/items/d9e9a220190549107282)が分かりやすい。

マイクロサービスパターン本だとメッセージングと絡めてSagaが紹介されているが、メルペイは同期APIで実現しているように見える（推測）。メッセージング基盤の障害が発生した場合のことを考えての判断だと思うが、可用性が下がらないのかが気になった。