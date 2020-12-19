---
title: "CPUの負荷状況とロードアベレージを見るための知識"
date: 2020-12-19T08:16:09+09:00
author: eiKatou
type: post
url: /20201219.html
archives:
  - 2020
tags:
  - IT技術
---

Webアプリケーションの負荷状態を見るための知識を身に付けたいが、なかなか難しくて苦戦している。ノウハウがいるところなので一朝一夕にはいかない。一歩ずつ知識を蓄えていくしかない。今週はCPUの負荷状況とロードアベレージについて調べた。

<!--more-->

# vmstatコマンドの読み方
- [Man page of VMSTAT](https://linuxjm.osdn.jp/html/procps/man8/vmstat.8.html)
- [vmstat(8) manページ](https://nxmnpg.lemoda.net/ja/8/vmstat)

ページよって解説が違うのはなぜ・・？
CPU周りを見ておきたい。us, sy, id, waが重要。

# CPUの項目について

[I/O負荷の正確な状況はiowaitでは分かりません - Qiita](https://qiita.com/kunihirotanaka/items/a536ee35d589027e4a5a)

> iowaitとはあくまでも、CPUが空いているのにI/Oがボトルネックになっているプロセスを示しているだけで、CPUの利用率が高いときにはI/Oがボトルネックになっていてもiowaitが上がりません。
> 同様に勘違いされがちなのが、id(idle)はCPUの空きを示しているというものですが、idleは必ずしもCPUの空き時間を示しているものではありません。
> us(user)がユーザプロセスでのCPU使用率、sy(system)がカーネルでのCPU使用率であり、userとsystemを足したものがいわゆるCPU使用率を示しています。
> そして、user + system + idle + iowait は必ず100になります（ここではstの説明は省きます）。

つまり・・、こういうことかな。

- cpuの使用率を見るためには、us+syを見る
- cpuの使用率が低いときは、idleかiowaitのどちらかが上がる
- cpuが空いているのにI/Oがボトルネックになっているときはiowaitが上がる


# ロードアベレージとは

聞いたことあるけど、あまり正確に理解していなかった。

[LinuxのI/OやCPUの負荷とロードアベレージの関係を詳しく見てみる - Qiita](https://qiita.com/kunihirotanaka/items/21194f77713aa0663e3b)

> 先ほどの項目で述べたとおり、ロードアベレージとはLinuxカーネルがCPUリソースを割り当てたプロセスの数と、I/O待ち状態が原因でCPUが利用されていないプロセスの合計を示しており、負荷状況を把握することができます。
> I/O負荷が全く無い状態を仮定すると、1プロセスがCPUを100%占有している際にはロードアベレージが1となり、2プロセスで100%占有している場合は2となります。
> ちなみに、CPUのコア数が1個の場合はロードアベレージが1になるとCPUが100%使用されている状態であり、コア数が16個の場合はロードアベレージ16になるとCPUが100%使用されている状態となります。
> 逆に、CPUの負荷がかかっていないのにロードアベレージが上昇している場合には、I/Oがボトルネックになっていることを示します。

[load averageを見てシステムの負荷を確認する - Qiita](https://qiita.com/k0kubun/items/8065f5cf2da7605c8043)

> load average、つまりシステムの負荷とは、「CPUの実行権限が与えられるのを待っているプロセス」と「ディスクI/Oの完了を待っているプロセス」の多さのことである。

自分の理解

- ロードアベレージが高いということはシステムの負荷が高く、なんらかの対策が必要
- CPUのコア数と一致する値になれば、CPUが100%使えている事になる

# 単一サーバーの負荷を見る
Webアプリのスループットやレスポンスタイムの悪化がある場合、サーバーの負荷を調べる。
サーバーの負荷を見るためには、まずはロードアベレージを見るところから始める。
- ロードアベレージが高い場合は、CPUかI/Oに問題がある。
  - CPUの状態はuser,systemのどちらが高いか。userであればプログラムの暴走が考えられる。
  - I/Oは、ディスクアクセスの総量や、メモリのスワップアウトを調べるのが良い。
- ロードアベレージが低い場合は、外部に原因があることが多い
  - ソフトウェア不具合や設定が誤っている
  - データベースや外部システムとの通信が遅い
  - 外部通信の量を見るために、サーバーからのネットワークI/OやTCPコネクション数を見ると良い

Webアプリだと複数のサーバーで構築されていることが多いので、全てのサーバーを見てみることも大切だ。さらにDBサーバーだとDB独自の注目ポイントもあるので、そういうところも見ていく必要がある。この辺りは今後知識として身に付けていきたい。

最近だと、vmstatとかsarを見ることはなくて、CloundWatch LogsやMackerel、Datadogが主流になってきている。これらのツールを使いこなす力も必要になってきているなと感じる。

---

以下の本にロードアベレージについて解説があったので、参考にさせてもらった。

<a href="https://www.amazon.co.jp/Web%E9%96%8B%E7%99%BA%E8%80%85%E3%81%AE%E3%81%9F%E3%82%81%E3%81%AE-%E5%A4%A7%E8%A6%8F%E6%A8%A1%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E6%8A%80%E8%A1%93%E5%85%A5%E9%96%80-%E2%80%95%E3%83%87%E3%83%BC%E3%82%BF%E6%A7%8B%E9%80%A0%E3%80%81%E3%83%A1%E3%83%A2%E3%83%AA%E3%80%81OS%E3%80%81DB%E3%80%81%E3%82%B5%E3%83%BC%E3%83%90-PRESS-plus%E3%82%B7%E3%83%AA%E3%83%BC%E3%82%BA/dp/4774143073/ref=as_li_ss_il?ie=UTF8&linkCode=li3&tag=eikatou-22&linkId=4b5f01d0fb0e70b2f428088d73ce6c08&language=ja_JP" target="_blank"><img border="0" src="//ws-fe.amazon-adsystem.com/widgets/q?_encoding=UTF8&ASIN=4774143073&Format=_SL250_&ID=AsinImage&MarketPlace=JP&ServiceVersion=20070822&WS=1&tag=eikatou-22&language=ja_JP" ></a><img src="https://ir-jp.amazon-adsystem.com/e/ir?t=eikatou-22&language=ja_JP&l=li3&o=9&a=4774143073" width="1" height="1" border="0" alt="" style="border:none !important; margin:0px !important;" />

- [［Web開発者のための］大規模サービス技術入門 ―データ構造，メモリ，OS，DB，サーバ/インフラ](https://gihyo.jp/magazine/wdpress/plus/978-4-7741-4307-1)
- [[Web開発者のための]大規模サービス技術入門 ―データ構造、メモリ、OS、DB、サーバ/インフラ - Amazon](https://amzn.to/38dt9AW)