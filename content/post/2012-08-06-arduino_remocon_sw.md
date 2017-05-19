---
title: Arduinoで創るネットワーク対応リモコン（ソフトウェア）
author: eiKatou
type: post
date: 2012-08-06T01:53:39+00:00
url: /1872.html
tags:
  - Arduino
  - Dev

---
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_sw1.jpg" alt="" title="arduino_remocon_sw1" width="376" height="451" class="alignnone size-full wp-image-1905" srcset="/uploads/2012/08/arduino_remocon_sw1.jpg 376w, /uploads/2012/08/arduino_remocon_sw1-250x300.jpg 250w" sizes="(max-width: 376px) 100vw, 376px" />][1]
  
[前回のハードウェア編][2]の続きの内容。ハードウェアが出来たので、ソフトウェアを書き込む。

<!--more-->

## リモコンの機能

リモコンの機能は、以下のものとした。

  * iPhone/Androidで、エアコン入切を制御（予約）ができる
  * エアコンに信号が送れるかのテストができる
  * 無料で運用できる

もとの日経Linuxの記事だと、「温度センサーで温度を見ながら制御する」ということだった。私には、そこまで必要ないので、時間で制御するようにした。特定の時間が来たら、エアコンが動いたり止まったりする。エアコン入切の予約は、iPhone/Androidなどで出来るようにする。外出中でも制御が可能だ。

もう一つ重要なのは、無料で運用できる点。Arduinoをネットワークに繋げて、ネットワーク上の命令で動くようにする。つまり、自由に処理を動かせるサーバ（PHPやRubyが動く）が必要だ。しかし、それだと有料になってしまう（GAEもあるけどね）。

そこで考えたのが、Dropboxで制御する方法。Dropboxのファイルに命令を書き込んでおいて、一定時間おきにArduinoが命令を確認しにいく。これだと無料で運用することができる。

## Arduinoのプログラム

Arduinoに以下のプログラムを書き込んだ。
  
[ソースコードをダウンロード][3]
  
[ソースコードをダウンロード（2013年7月13日修正版）][4] 

### エアコンの制御信号

エアコンの制御信号は[この記事][5]で取得したものを埋め込んだ。外部から読み込むのは複雑になりそうだったから。

エアコンの制御信号は数が多いので、普通に配列に入れると、メモリ不足でプログラムが止まってしまう。何も言わずにバッサリと落ちてしまう。この問題は「PROGMEM」で解決した。

  * [動けばおｋ！ PROGMEMの使い方][6]
  * [Arduino &#8211; PROGMEM][7]

### Dropbox上のファイルを取得

[Arduinoでネットワークアクセス][8]で勉強していたので、簡単にDropbox上のファイルを取得できた。このプログラムでは5分おきにファイルを取得する。

### 時間を取得する

意外と大変だったのが、時間を取得する処理。Arduino単体では、時間は取得することが出来ないのだ。電源投入時に時間を書き込むか・・、NTPで時間を取得するしかない。

今回は、NTPで取得することにした。NTPを取得する方法は、[NTPを使ってインターネット経由で時刻をあわせる][9]を参考にした。

ArduinoのTimeライブラリの導入は、（Macだと）「~/Documents/Arduino/libraries/Time/」というフォルダを作成し、Time.hやTime.cppを置いて、Arduino開発環境を再起動する。
  
Windowsでも、ソースコードが配置されるフォルダと一緒の階層に、librariesフォルダを作れば良いはず。

### タクトスイッチ

タクトスイッチはテスト用のものだ。タクトスイッチを押すと、リモコンの信号を送信する。エアコンに向くように、リモコン本体の角度調整が必要なので、手軽にリモコン信号を送信する機能が必要だった。

## Dropbox上のファイル

こんなファイル（[Controller.txt][10]）を置いている。
  
[bash]
  
;Format:"$HHMM:COMMAND"

-start-

$1800:OFF
  
$1820:OFF
  
$2150:OFF
  
$0430:ON
  
$0520:OFF

-end-

[/bash] 

プログラム内で”$HHMM:”から始まる文字を探しに行って、見つかると”ON”か”OFF”のコマンドを読み込む。ONだとエアコンにスイッチを入れる制御信号を送り、OFFだとスイッチを切る制御信号を送る。”$”以外から始まるの行はスキップされる。

時間は10分間隔の指定となる。18時2分にArduinoがこのファイルを処理すると、”$1800:OFF”が命令対象となり、エアコンを停止する信号が送られる。

18時12分にArduinoがこのファイルを処理すると、”$1810:XX”が命令対象となる。この命令はファイルに無いので、何も実行せずにスキップする。

＊最後に改行のみの行が必要。最後の空行で、終了判定をしている。 

* * *

[Arduinoで創るネットワーク対応リモコン（完成！）][11]につづく・・

 [1]: http://eikatou.net/blog/wp-content/uploads/2012/08/arduino_remocon_sw1.jpg
 [2]: http://eikatou.net/blog/2012/08/arduino_remocon_hw/
 [3]: http://eikatou.net/blog/wp-content/uploads/2012/08/NetController.zip
 [4]: http://eikatou.net/blog/wp-content/uploads/2012/08/NetController.ino_20130713.zip
 [5]: http://eikatou.net/blog/2012/07/arduino-remocon/
 [6]: http://hsgw.blog10.fc2.com/blog-entry-16.html
 [7]: http://arduino.cc/en/Reference/PROGMEM
 [8]: http://eikatou.net/blog/2012/07/arduino-network/
 [9]: http://arms22.blog91.fc2.com/blog-entry-445.html
 [10]: http://eikatou.net/blog/wp-content/uploads/2012/08/Controller.txt
 [11]: http://eikatou.net/blog/2012/08/arduino_remocon_kansei/
