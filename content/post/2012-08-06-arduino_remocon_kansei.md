---
title: Arduinoで創るネットワーク対応リモコン（完成！）
author: eiKatou
type: post
date: 2012-08-06T02:31:10+00:00
url: /1898.html
archives:
  - 2012
tags:
  - Arduino
  - Dev

---
![_](/uploads/2012/08/arduino_remocon_kansei1.jpg)
  
ダンボー「新入りか・・」

## リモコンの角度を調整

リモコンの向きを、エアコンに向けないといけない。赤外線LEDは、一定方向にしか光を出せないからだ。タクトスイッチを押して、テスト用の信号を送信する。何回か押して、ちょうど良い角度を見つけた。

「breffo spider podium Black」というマルチスタンドで角度を固定している。

<div class="amazlet-box" style="margin-bottom:0px;">
  <div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;">
    <a href="http://www.amazon.co.jp/exec/obidos/ASIN/B0045CI0MY/eikatou-22/ref=nosim/" name="amazletlink" target="_blank"><img src="http://ecx.images-amazon.com/images/I/21gBbfwag0L._SL160_.jpg" alt="日本トラストテクノロジー マルチスタンド breffo spider podium Black SPIDERPODIUMBK" style="border: none;" /></a>
  </div>
  
  <div class="amazlet-info" style="line-height:120%; margin-bottom: 10px">
    <div class="amazlet-name" style="margin-bottom:10px;line-height:120%">
      <a href="http://www.amazon.co.jp/exec/obidos/ASIN/B0045CI0MY/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">日本トラストテクノロジー マルチスタンド breffo spider podium Black SPIDERPODIUMBK</a> 
      <div class="amazlet-powered-date" style="font-size:80%;margin-top:5px;line-height:120%">
        posted with <a href="http://www.amazlet.com/browse/ASIN/B0045CI0MY/eikatou-22/ref=nosim/" title="日本トラストテクノロジー マルチスタンド breffo spider podium Black SPIDERPODIUMBK" target="_blank">amazlet</a> at 12.08.06
      </div>
    </div>
    <div class="amazlet-detail">
      日本トラストテクノロジー (2010-10-06)<br />売り上げランキング: 29697
    </div>
    <div class="amazlet-sub-info" style="float: left;">
      <div class="amazlet-link" style="margin-top: 5px">
        <a href="http://www.amazon.co.jp/exec/obidos/ASIN/B0045CI0MY/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jp で詳細を見る</a>
      </div>
    </div>
  </div>
  <div class="amazlet-footer" style="clear: left">
  </div>
</div>

## PlainTextでファイル書き換え

![_](/uploads/2012/08/arduino_remocon_kansei2.jpg)
  
Dropboxの中の設定ファイルを書き換えるために、iPhone用アプリをインストール。「PlainText」フォルダの中しか同期できないのが残念だが、無料なので「PlainText」にした。


## 運用開始！

PlainTextで設定ファイルを書き換えて、しばらく待つと・・
  
　・
  
　・
  
　・
  
「ピッ！」と鳴って、エアコンが動き始めた！

夜中もしっかりと動いてくれて、朝に暑さで目覚めることもなくなった。

* * *

完成まで一週間以上かかったけど、非常に勉強になった。やっぱり、自分で作るのはとても楽しいね。

  * [Arduinoで創るネットワーク対応リモコン（メンテナンス）][3]
  * [Arduinoで創るネットワーク対応リモコン（完成！）][4]
  * [Arduinoで創るネットワーク対応リモコン（ソフトウェア）][5]
  * [Arduinoで創るネットワーク対応リモコン（ハードウェア）][6]

* * *

＃以下、作成に使用した部品一覧

＊ 本体
  
[スイッチサイエンス Arduino Ethernet][7]

＊ シールド
  
[スイッチサイエンス/商品詳細 Arduino用バニラシールド基板ver.2(白)][8]

＊ 部品

  * 赤外線LED：OSI5LA5113A （[秋月][9]） ＋ 抵抗 47Ω （[秋月][10]）
  * 赤色LED：OSDR3133A（[秋月][11]） ＋ 抵抗 150Ω（[秋月][12]）
  * 青色LED：SLR343BCTT32（[秋月][13]） ＋ 抵抗 100Ω（[秋月][14]）
  * タクトスイッチ（[秋月][15]） ＋ 抵抗 300Ω（[秋月][16]）

＊ 参考書

<div class="amazlet-box" style="margin-bottom:0px;">
  <div class="amazlet-image" style="float:left;margin:0px 12px 1px 0px;">
    <a href="http://www.amazon.co.jp/exec/obidos/ASIN/487311537X/eikatou-22/ref=nosim/" name="amazletlink" target="_blank"><img src="http://ecx.images-amazon.com/images/I/51zFePM-naL._SL160_.jpg" alt="Arduinoをはじめよう 第2版 (Make:PROJECTS)" style="border: none;" /></a>
  </div>
  <div class="amazlet-info" style="line-height:120%; margin-bottom: 10px">
    <div class="amazlet-name" style="margin-bottom:10px;line-height:120%">
      <a href="http://www.amazon.co.jp/exec/obidos/ASIN/487311537X/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">Arduinoをはじめよう 第2版 (Make:PROJECTS)</a></p> 
      <div class="amazlet-powered-date" style="font-size:80%;margin-top:5px;line-height:120%">
        posted with <a href="http://www.amazlet.com/browse/ASIN/487311537X/eikatou-22/ref=nosim/" title="Arduinoをはじめよう 第2版 (Make:PROJECTS)" target="_blank">amazlet</a> at 12.08.09
      </div>
    </div>
    <div class="amazlet-detail">
      Massimo Banzi <br />オライリージャパン <br />売り上げランキング: 2097
    </div>
    <div class="amazlet-sub-info" style="float: left;">
      <div class="amazlet-link" style="margin-top: 5px">
        <a href="http://www.amazon.co.jp/exec/obidos/ASIN/487311537X/eikatou-22/ref=nosim/" name="amazletlink" target="_blank">Amazon.co.jp で詳細を見る</a>
      </div>
    </div>
  </div>
  <div class="amazlet-footer" style="clear: left">
  </div>
</div>

 [1]: /uploads/2012/08/arduino_remocon_kansei1.jpg
 [2]: /uploads/2012/08/arduino_remocon_kansei2.jpg
 [3]: /2954.html
 [4]: /1898.html
 [5]: /1872.html
 [6]: /1837.html
 [7]: http://www.switch-science.com/products/detail.php?product_id=698
 [8]: http://www.switch-science.com/products/detail.php?product_id=990
 [9]: http://akizukidenshi.com/catalog/g/gI-04311/
 [10]: http://akizukidenshi.com/catalog/g/gR-25470/
 [11]: http://akizukidenshi.com/catalog/g/gI-00562/
 [12]: http://akizukidenshi.com/catalog/g/gR-25151/
 [13]: http://akizukidenshi.com/catalog/g/gI-03988/
 [14]: http://akizukidenshi.com/catalog/g/gR-25101/
 [15]: http://akizukidenshi.com/catalog/g/gP-03647/
 [16]: http://akizukidenshi.com/catalog/g/gR-25331/
