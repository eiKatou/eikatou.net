---
title: "現場で役立つシステム設計の原則"
date: 2017-12-06T14:40:00+09:00
author: eiKatou
type: post
url: /20171206.html
archives:
  - 2017
tags:
  - 読書
---

<a href="https://www.amazon.co.jp/%E7%8F%BE%E5%A0%B4%E3%81%A7%E5%BD%B9%E7%AB%8B%E3%81%A4%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E8%A8%AD%E8%A8%88%E3%81%AE%E5%8E%9F%E5%89%87-%E5%A4%89%E6%9B%B4%E3%82%92%E6%A5%BD%E3%81%A7%E5%AE%89%E5%85%A8%E3%81%AB%E3%81%99%E3%82%8B%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E6%8C%87%E5%90%91%E3%81%AE%E5%AE%9F%E8%B7%B5%E6%8A%80%E6%B3%95-%E5%A2%97%E7%94%B0-%E4%BA%A8-ebook/dp/B073GSDBGT/ref=as_li_ss_il?_encoding=UTF8&qid=&sr=&linkCode=li3&tag=eikatou-22&linkId=5901d25791506db587d2f56c37c77258" target="_blank"><img border="0" src="//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=B073GSDBGT&Format=_SL250_&ID=AsinImage&MarketPlace=JP&ServiceVersion=20070822&WS=1&tag=eikatou-22" ></a><img src="https://ir-jp.amazon-adsystem.com/e/ir?t=eikatou-22&l=li3&o=9&a=B073GSDBGT" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />

[現場で役立つシステム設計の原則｜Amazon](http://amzn.to/2AvQnTJ)  
[現場で役立つシステム設計の原則｜技術評論社](http://gihyo.jp/book/2017/978-4-7741-9087-7)

軽い気持ちで買った本だったけど、思った以上に良かった。

<!--more-->

第1章と第2章は、プログラミングのテクニックに関する内容。

- 値オブジェクト
- コレクションオブジェクト
- 区分をEnum型で表現する

第3章と第4章は、ドメインモデルの説明と構築方法。

- データクラスと機能クラスを分けると変更が大変になる
- 業務ロジックを整理し、ドメインモデルを作る
- 業務の関心ごとをヒト・モノ・コトで整理する
- 業務知識をプログラムで表現したドメインモデルを作ると、業務ロジックが集約され、変更が容易となる

第5章からは、DB設計や画面設計、開発プロセスに関する内容が続く。

第9章の開発プロセスに関する内容が面白かった。

> ソフトウェア全体をわかりすい構造で整理 する基本は、複雑な業務ロジックをドメインモデルに集約し、整理することです。そのためには、業務を理解し整理するための「分析」と、ソフトウェアとしての実現方法を考える「設計」を、同じ人間／チームが一貫して担当することが効果的です。

前から自分も感じていたことで、業務分析・設計・実装を同じ人が担当する方が良いものができる。何故ならば、上流工程の知識をそのままプログラムに落とし込めるから。自分が関係したプロジェクトでは、設計者と実装者が違うことによって、業務知識のない実装者がバグを作り込んでいた。品質に大きく影響するのだと実感した。

> 分析と設計を一 体で進めるオブジェクト指向の開発スタイルでは、このドキュメントを作成するための調査や分析作業は、ドメインモデルを設計し実装するチームが担当します。 同じチームが担当するので、大量にドキュメントを作ってから、それをプログラミング言語で書き換えていく作業はムダです。分析しながら理解した内容を、直接ソースコードとして記録し、確認していくほうが効率的です。そして、業務を理解している人間が直接プログラムを書いているのですから、要求の取り違えや抜け漏れが起きにくくなります。

ドキュメントを作ることは知識を書き出すことで、どちらかというと良いことだと思っていた。ここではハッキリとムダと書いていて、良い意味での驚きがあった。

ソースコードが分かりやすく書いているならば、ソースコードを読めば良い。それがドキュメントだと言い切ることができる。確かに・・！

> システムの基本的な目的や、方向性を関係者で共有することも大切です。しかし、これはソースコードだけでは共有しにくい内容です。 基本目的や方向性を共有するための情報として次のものがあります。
> ・システム企画書やプロジェクト計画書のシステム概要説明
> ・プレスリリース
> ・リリースノート
> ・利用者ガイドの導入部
> ・営業ツールのキャッチフレーズ
> これらの情報は、頻繁に更新されることはありません。しかし、重要な点を要約した貴重な情報です

必要なドキュメントもあるという点も記述されている。

---

この本は、ドメインモデルの解説書だと思って読んだ方が良い。参考書籍も載っていて、他の本でも勉強しようという気になった。新しく出たドメインモデルの本も読んでみようと思う。

しかし、やや疑問に感じる記述もあった。DB設計に関する章では、「テーブルにカラムを追加したい時は別テーブルにする。」と書いてあった。過去データに対しては新しいカラムにデータを入れられない、虚偽の値を入れるぐらいならば分けた方が良い、という考えである。

システム改修によってテーブルが大量に作られたシステムは、分かりやすいシステムと言えるだろうか。長期間、システムの運用保守をすることを考えると、データモデルとしてあるべき姿を作っていくべきだと考える。過去データに正しい値を入れて、カラム追加も十分にあり得る選択肢だと思った。

やや極端な考えもあるが、全体として良い本だと思った。

---

<div class="amazlet-box" style="margin-bottom:0px;"><div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B073GSDBGT/eikatou-22/ref=nosim/" name="amazletlink" target="_blank"><img src="https://images-fe.ssl-images-amazon.com/images/I/51QSqJm2ZOL._SL160_.jpg" alt="現場で役立つシステム設計の原則 〜変更を楽で安全にするオブジェクト指向の実践技法" style="border: none;" /></a></div><div class="amazlet-info" style="line-height:120%; margin-bottom: 10px"><div class="amazlet-name" style="margin-bottom:10px;line-height:120%"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B073GSDBGT/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">現場で役立つシステム設計の原則 〜変更を楽で安全にするオブジェクト指向の実践技法</a><div class="amazlet-powered-date" style="font-size:80%;margin-top:5px;line-height:120%">posted with <a href="http://www.amazlet.com/" title="amazlet" target="_blank">amazlet</a> at 17.12.06</div></div><div class="amazlet-detail">技術評論社 (2017-07-05)<br />売り上げランキング: 3,809<br /></div><div class="amazlet-sub-info" style="float: left;"><div class="amazlet-link" style="margin-top: 5px"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B073GSDBGT/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jpで詳細を見る</a></div></div></div><div class="amazlet-footer" style="clear: left"></div></div>
