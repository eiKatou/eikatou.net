---
title: Arduinoで創るネットワーク対応リモコン（ハードウェア）
author: eiKatou
type: post
date: 2012-08-05T12:27:19+00:00
url: /1837.html
categories:
  - Arduino
  - Dev

---
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_hd5.jpg" alt="" title="arduino_remocon_hd5" width="452" height="339" class="alignnone size-full wp-image-1842" srcset="/uploads/2012/08/arduino_remocon_hd5.jpg 452w, /uploads/2012/08/arduino_remocon_hd5-300x225.jpg 300w, /uploads/2012/08/arduino_remocon_hd5-400x300.jpg 400w" sizes="(max-width: 452px) 100vw, 452px" />][1]
  
[株式会社鳥人間][2]の[(株)鳥人間社長 (hisashin)][3]さんの記事に触発されて、買ってきたArduino Ethernet。ようやくネットワーク対応のエアコン制御ができるようになった。

長くなりそうだったので、ソフトウェアとハードウェアで分けた。

<!--more-->

## 配線を考える

まずは配線を考える。といってもブレッドボードで、いろいろ試しているうちに、出来てしまった。

[<img src="http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_hd1.jpg" alt="" title="arduino_remocon_hd1" width="338" height="451" class="alignnone size-full wp-image-1843" srcset="/uploads/2012/08/arduino_remocon_hd1.jpg 338w, /uploads/2012/08/arduino_remocon_hd1-224x300.jpg 224w" sizes="(max-width: 338px) 100vw, 338px" />][4]
  
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
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_hd2.jpg" alt="" title="arduino_remocon_hd2" width="452" height="340" class="alignnone size-full wp-image-1841" srcset="/uploads/2012/08/arduino_remocon_hd2.jpg 452w, /uploads/2012/08/arduino_remocon_hd2-300x225.jpg 300w, /uploads/2012/08/arduino_remocon_hd2-398x300.jpg 398w" sizes="(max-width: 452px) 100vw, 452px" />][20]
  
力技で分割！

[<img src="http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_hd3.jpg" alt="" title="arduino_remocon_hd3" width="452" height="452" class="alignnone size-full wp-image-1840" srcset="/uploads/2012/08/arduino_remocon_hd3.jpg 452w, /uploads/2012/08/arduino_remocon_hd3-150x150.jpg 150w, /uploads/2012/08/arduino_remocon_hd3-300x300.jpg 300w" sizes="(max-width: 452px) 100vw, 452px" />][21]
  
ぴったりサイズになった！ 

## はんだ付け

以下の手順で、部品の取り付けを行う。

  1. シールドとピンヘッダをはんだ付け
  2. シールドを取り外して裏返す
  3. それぞれの部品をはんだ付け

裏面はこんな感じ。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_hd6.jpg" alt="" title="arduino_remocon_hd6" width="451" height="338" class="alignnone size-full wp-image-1845" srcset="/uploads/2012/08/arduino_remocon_hd6.jpg 451w, /uploads/2012/08/arduino_remocon_hd6-300x224.jpg 300w, /uploads/2012/08/arduino_remocon_hd6-400x300.jpg 400w" sizes="(max-width: 451px) 100vw, 451px" />][22]

表面はこんな感じ。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_hd4.jpg" alt="" title="arduino_remocon_hd4" width="452" height="339" class="alignnone size-full wp-image-1839" srcset="/uploads/2012/08/arduino_remocon_hd4.jpg 452w, /uploads/2012/08/arduino_remocon_hd4-300x225.jpg 300w, /uploads/2012/08/arduino_remocon_hd4-400x300.jpg 400w" sizes="(max-width: 452px) 100vw, 452px" />][23]
  
＊青色LEDの隣の抵抗は、47Ω x 2個 から 100Ωの抵抗に変更した。 

## ACアダプタ

ACアダプタを繋いで、電気が通ることを確認する。ACアダプタも買ってきた。Arduinoは、外部電源で7V～12Vが推奨範囲となっている。USBから5Vを給電しても良いのだが、推奨に従ってACアダプタを買った。9V 1A センタープラスのACアダプタを500円で購入。

## 電気を通すと・・

ACアダプタに繋いで、赤外線LED、赤色LED、青色LED、タクトスイッチが正常に動くことを確認した。はんだ付けは超初心者なので、これだけで3時間ぐらいかかっている。うまく繋がっていて一安心だ。次はソフトウェアを書き込む。

* * *

[Arduinoで創るネットワーク対応リモコン（ソフトウェア）][24]につづく・・

 [1]: http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_hd5.jpg
 [2]: http://www.tori.st/
 [3]: https://twitter.com/hisashin
 [4]: http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_hd1.jpg
 [5]: http://akizukidenshi.com/catalog/g/gI-04311/
 [6]: http://akizukidenshi.com/catalog/g/gR-25470/
 [7]: http://akizukidenshi.com/catalog/g/gI-00562/
 [8]: http://akizukidenshi.com/catalog/g/gR-25151/
 [9]: http://akizukidenshi.com/catalog/g/gI-03988/
 [10]: http://akizukidenshi.com/catalog/g/gP-03647/
 [11]: http://akizukidenshi.com/catalog/g/gR-25331/
 [12]: http://eikatou.net/blog/2012/08/arduino_tactswitch/
 [13]: http://eikatou.net/blog/2012/07/arduino-remocon/
 [14]: http://eikatou.net/blog/2012/07/arduino-network/
 [15]: http://eikatou.net/blog/2012/07/arduino_led/
 [16]: http://eikatou.net/blog/2012/07/ardiono-buy/
 [17]: http://d.hatena.ne.jp/OkibiWorksLabo/20100429/shield
 [18]: http://www.switch-science.com/products/detail.php?product_id=990
 [19]: http://www.switch-science.com/products/detail.php?product_id=92
 [20]: http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_hd2.jpg
 [21]: http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_hd3.jpg
 [22]: http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_hd6.jpg
 [23]: http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_hd4.jpg
 [24]: http://eikatou.net/blog/2012/08/arduino_remocon_sw/
