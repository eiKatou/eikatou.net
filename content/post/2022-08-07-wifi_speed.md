---
title: "自宅WiFi環境の速度アップ"
date: 2022-08-07T10:00:43+09:00
author: eiKatou
type: post
url: /20220807.html
archives:
  - 2022
tags:
  - 雑記
---

[自作PCを作った時](20220705.html)に買ったWiFi子機 TP-Link Archer T3U Plus。

デスクトップ機に繋いでいると、なぜか速度が出ないという問題が気になっていた。

<!--more-->

# 環境
デスクトップ機は3階においてあって、WiFiルーターは2階に置いてある。
WiFiは11acで接続している。

T3U PlusはデスクトップのUSB端子に刺している。

# T3U Plusを使わない時の速度
T3U Plusの問題かもしれないので、T3U Plusを使わない状況での速度を調べる。

## 有線接続
MacBookからWiFiルーターに有線で繋いで速度を計測。
```
------ BNRスピードテスト (ダウンロード速度) ------
測定サイト： https://www.musen-lan.com/speed/ Ver10.0068
測定日時： 2022年07月28日(木) 20時26分55秒
--------------------------------------------------
SAKURA：238.17Mbps (29.77MB/sec)
WebArena：443.94Mbps (55.49MB/sec)
データ転送速度： 443.94Mbps (55.49MB/sec)
```

## 無線接続
MacBookで3階のデスクトップ機の近くから無線で繋いで速度を計測。MacBook内蔵のWiFiを利用。
```
------ BNRスピードテスト (ダウンロード速度) ------
測定サイト： https://www.musen-lan.com/speed/ Ver10.0068
測定日時： 2022年07月28日(木) 20時43分33秒
--------------------------------------------------
SAKURA：80.11Mbps (10.01MB/sec)
WebArena：226.32Mbps (28.29MB/sec)
データ転送速度： 226.32Mbps (28.29MB/sec)
```

# 半分の速度しか出ない問題
計測結果を取り忘れたんだけど、3階のデスクトップ機からT3U Plus経由の接続速度は100Mbps程度であった。なぜかMacBookProの半分しか出ない。

# USBの延長コードで解決
アンテナの角度とかいろいろ試してみて分かったことは、アンテナの位置が悪いということ。

デスクトップ機から少しでも離すと速度が改善する。また、どこに置くかでも微妙に速度が変わってくる。

## デスクトップ機にT3U Plusを直挿しで計測
```
------ BNRスピードテスト (ダウンロード速度) ------
測定サイト： https://www.musen-lan.com/speed/ Ver10.0068
測定日時： 2022年08月06日(土) 04時05分16秒
--------------------------------------------------
SAKURA：138.5Mbps (17.31MB/sec)
WebArena：58.7Mbps (7.34MB/sec)
データ転送速度： 138.5Mbps (17.31MB/sec)
```

## USB延長コードにT3U Plusを挿しで計測
```
------ BNRスピードテスト (ダウンロード速度) ------
測定サイト： https://www.musen-lan.com/speed/ Ver10.0068
測定日時： 2022年08月06日(土) 04時10分41秒
--------------------------------------------------
SAKURA：174.29Mbps (21.79MB/sec)
WebArena：223.22Mbps (27.9MB/sec)
データ転送速度： 223.22Mbps (27.9MB/sec)
```

# 最後に
速度が出なかったのはデスクトップ機の筐体が金属製だから？  
あまり納得いかない改善方法だけど、速度が改善されてよかった。  