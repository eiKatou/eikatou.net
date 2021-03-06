---
title: Arduinoで創るネットワーク対応リモコン（ハードウェア）
author: eiKatou
type: post
date: 2012-08-05T12:27:19+00:00
url: /1837.html
archives:
  - 2012
tags:
  - Arduino
  - Dev

---
![_](/uploads/2012/08/arduino_remocon_hd5.jpg)
  
[株式会社鳥人間][2]の[(株)鳥人間社長 (hisashin)][3]さんの記事に触発されて、買ってきたArduino Ethernet。ようやくネットワーク対応のエアコン制御ができるようになった。

長くなりそうだったので、ソフトウェアとハードウェアで分けた。

<!--more-->

## 配線を考える

まずは配線を考える。といってもブレッドボードで、いろいろ試しているうちに、出来てしまった。

![_](/uploads/2012/08/arduino_remocon_hd1.jpg)
  
右から・・

  * 赤外線LED：OSI5LA5113A （[秋月][5]） ＋ 抵抗 47Ω （[秋月][6]）
  * 赤色LED：OSDR3133A（[秋月][7]） ＋ 抵抗 150Ω（[秋月][8]）
  * 青色LED：SLR343BCTT32（[秋月][9]） ＋ 抵抗 47Ω（[秋月][6]） 2本
  * タクトスイッチ（[秋月][10]） ＋ 抵抗 300Ω（[秋月][11]）

リモコンだけなら、赤外線LEDと抵抗の2部品で良いのだが、使い勝手も考えてLEDとタクトスイッチを追加した。

今までの積み重ねの成果が発揮された。
  
今までの分は、以下を参照。

  * [Arduinoでユーザ入力を読み取り（タクトスイッチ）][12]
  * [Arduinoでリモコン作成][13]
  * [Arduinoでネットワークアクセス][14]
  * [ArduinoでLEDを光らせる][15]
  * [Arduino Ethernetを購入][16]

## バニラシールド

ブレッドボードで運用することもできるが、電子工作の醍醐味を味わうために、基板に取り付けることにした（醍醐味だけの理由ではないが・・）。

調査していて、Arduinoは通常の基板がはまらないという事が判明。穴の位置が少しずれているらしい（[自作バニラ（プロトシールド）を真似して作ってみた（ちょっと改良もあるよ！） &#8211; 熾火研究所＊電子工作室][17]）。

シールドを自作することも考えたが、ここは買って手間を削減することにした。
  
[スイッチサイエンスのバニラシールド(白)][18]と[ピンヘッダ10本セット][19]を購入。

装着してみたが、Ethernet端子が大きくて浮いてしまう・・。長いピンヘッダを買えば、きれいに解決できるのだが、めんどくさい。

こうすれば簡単に解決する。
  
![_](/uploads/2012/08/arduino_remocon_hd2.jpg)
  
力技で分割！

![_](/uploads/2012/08/arduino_remocon_hd3.jpg)
  
ぴったりサイズになった！ 

## はんだ付け

以下の手順で、部品の取り付けを行う。

  1. シールドとピンヘッダをはんだ付け
  2. シールドを取り外して裏返す
  3. それぞれの部品をはんだ付け

裏面はこんな感じ。
  
![_](/uploads/2012/08/arduino_remocon_hd6.jpg)

表面はこんな感じ。
  
![_](/uploads/2012/08/arduino_remocon_hd4.jpg)
  
＊青色LEDの隣の抵抗は、47Ω x 2個 から 100Ωの抵抗に変更した。 

## ACアダプタ

ACアダプタを繋いで、電気が通ることを確認する。ACアダプタも買ってきた。Arduinoは、外部電源で7V～12Vが推奨範囲となっている。USBから5Vを給電しても良いのだが、推奨に従ってACアダプタを買った。9V 1A センタープラスのACアダプタを500円で購入。

## 電気を通すと・・

ACアダプタに繋いで、赤外線LED、赤色LED、青色LED、タクトスイッチが正常に動くことを確認した。はんだ付けは超初心者なので、これだけで3時間ぐらいかかっている。うまく繋がっていて一安心だ。次はソフトウェアを書き込む。

* * *

[Arduinoで創るネットワーク対応リモコン（ソフトウェア）][24]につづく・・

 [1]: /uploads/2012/08/arduino_remocon_hd5.jpg
 [2]: http://www.tori.st/
 [3]: https://twitter.com/hisashin
 [4]: /uploads/2012/08/arduino_remocon_hd1.jpg
 [5]: http://akizukidenshi.com/catalog/g/gI-04311/
 [6]: http://akizukidenshi.com/catalog/g/gR-25470/
 [7]: http://akizukidenshi.com/catalog/g/gI-00562/
 [8]: http://akizukidenshi.com/catalog/g/gR-25151/
 [9]: http://akizukidenshi.com/catalog/g/gI-03988/
 [10]: http://akizukidenshi.com/catalog/g/gP-03647/
 [11]: http://akizukidenshi.com/catalog/g/gR-25331/
 [12]: /1821.html
 [13]: /1796.html
 [14]: /1760.html
 [15]: /1699.html
 [16]: /1663.html
 [17]: http://d.hatena.ne.jp/OkibiWorksLabo/20100429/shield
 [18]: http://www.switch-science.com/products/detail.php?product_id=990
 [19]: http://www.switch-science.com/products/detail.php?product_id=92
 [20]: /uploads/2012/08/arduino_remocon_hd2.jpg
 [21]: /uploads/2012/08/arduino_remocon_hd3.jpg
 [22]: /uploads/2012/08/arduino_remocon_hd6.jpg
 [23]: /uploads/2012/08/arduino_remocon_hd4.jpg
 [24]: /1872.html
