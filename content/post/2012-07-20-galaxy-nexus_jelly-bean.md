---
title: Galaxy NexusにJelly beanを導入
author: eiKatou
type: post
date: 2012-07-20T09:41:39+00:00
url: /1675.html
archives:
  - 2012
tags:
  - Android

---
[<img src="/blog/uploads/2012/07/jb-new-logo.png" alt="" title="jb-new-logo" width="206" height="316" class="alignnone size-full wp-image-1676" srcset="/blog/uploads/2012/07/jb-new-logo.png 206w, /blog/uploads/2012/07/jb-new-logo-195x300.png 195w" sizes="(max-width: 206px) 100vw, 206px" />][1]
  
Galaxy Nexusに、Android 4.1(Jelly bean)を導入した。

## 手順

「[Google、GSM/HSPA+対応版Galaxy Nexus向けにAndroid 4.1（Jelly Bean）へのアップデートを配信開始 | juggly.cn][2]」とのことで、待っていたけど、なかなかアップデートが来ない。
  
それもそのはずで、私のGalaxy Nexusは&#8221;yakjusz&#8221;で、&#8221;yakju&#8221;ではなかった。という事で、&#8221;yakju&#8221;のFactory Image(公式 4.0.4)を導入して、OTAアップデートで4.1に上げることにした。

簡単に書くと、以下の手順となる。

  1. OEM Unlock
  2. ClockworkMod Recovery導入
  3. Wipe
  4. Factory Image(&#8220;yakju&#8221;)導入
  5. システムアップデート

<!--more-->

以下のサイトを先に読んでおくと良い。

  * [GALAXY Nexus (docomo SC-04D) oem unlock～clockworkMod recoveryによるバックアップ &#8211; Kazzzの日記][3]
  * [Galaxy Nexus(SC-04D)にイギリス版ROM(ビルド番号ITL41F)を手動アップデートする方法。 &#8211; Android(アンドロイド)おすすめアプリ・カスタム情報|AndroidLover.Net][4]

（注意）私のGalaxy NexusはDocomo版ではない。Docomo版ではradio.imgを書き戻す必要があるだろう（[参考][5]）。

## OEM Unlock

音量の上ボタンと下ボタンを同時に押しながら、電源ボタンを押すと、ブートローダーが起動してくる。ここでfastbootコマンドを打つ。
  
[bash]
  
katou-no-MacBook-Air:~ ei$ fastboot devices
  
014696C30501A01C fastboot
  
katou-no-MacBook-Air:~ ei$ fastboot oem unlock
  
&#8230;
  
OKAY [ 81.113s]
  
finished. total time: 81.113s
  
[/bash]

[<img src="/blog/uploads/2012/07/GN_oemunlock.jpg" alt="" title="GN_oemunlock" width="451" height="601" class="alignnone size-full wp-image-1681" srcset="/blog/uploads/2012/07/GN_oemunlock.jpg 451w, /blog/uploads/2012/07/GN_oemunlock-225x300.jpg 225w" sizes="(max-width: 451px) 100vw, 451px" />][6]
  
ロック解除画面が立ち上がってくるので、音量の上ボタンを押してYESを選択して、電源ボタンで実行する。OEM Unlock完了。 

## ClockworkMod Recovery導入

まずは、「[[RECOVERY] ClockworkMod Recovery \*GSM Edition\* &#8211; xda-developers][7]」をダウンロード。

音量の上ボタン＋下ボタン＋電源ボタンで、ブートローダーを起動する。fastbootコマンドで、ClockworkMod Recoveryでブートするようにする。
  
[bash]
  
katou-no-MacBook-Air:galaxynexus ei$ fastboot boot recovery-clockwork-5.5.0.2-maguro.img
  
downloading &#8216;boot.img&#8217;&#8230;
  
OKAY [ 0.835s]
  
booting&#8230;
  
OKAY [ 0.329s]
  
finished. total time: 1.164s
  
[/bash]
  
[<img src="/blog/uploads/2012/07/GN_CWM.jpg" alt="" title="GN_CWM" width="338" height="451" class="alignnone size-full wp-image-1683" srcset="/blog/uploads/2012/07/GN_CWM.jpg 338w, /blog/uploads/2012/07/GN_CWM-224x300.jpg 224w" sizes="(max-width: 338px) 100vw, 338px" />][8]
  
起動すると、青い文字の画面となる。

下にエラーが出ているが、これはOEM Unlock後にAndroidを起動すると表示されなくなる(? 記憶が曖昧。Wipeだったかも）。ここでは何もせず、Androidを起動して、再度ClockworkMod Recoveryを起動してから、先に進むと良い。 

もちろん、ここでNANDバックアップも取得しておく。

## Wipe

順にwipeしていく。

  1. 「wipe data/factory reset」
  2. 「wipe cache partition」
  3. 「advanced」から「wipe Dalvik Cache」
  4. 「advanced」から「wipe Battery Stats」

## Factory Image導入

公式のAndroidのROMは、「[Factory Images for Nexus Devices &#8211; Android — Google Developers][9]」から入手可能。ここから、&#8221;yakju&#8221;をダウンロード。解凍すると、インストールのシェルなどがあるはずだ。

ブートローダー画面にして、インストールのシェルを流す。
  
[bash]
  
katou-no-MacBook-Air:yakju-imm76i ei$ ./flash-all.sh
  
sending &#8216;bootloader&#8217; (2308 KB)&#8230;
  
OKAY [ 0.367s]
  
writing &#8216;bootloader&#8217;&#8230;
  
OKAY [ 0.301s]
  
finished. total time: 0.668s
  
rebooting into bootloader&#8230;
  
OKAY [ 0.006s]
  
finished. total time: 0.006s
  
sending &#8216;radio&#8217; (12288 KB)&#8230;
  
OKAY [ 1.825s]
  
writing &#8216;radio&#8217;&#8230;
  
OKAY [ 1.364s]
  
finished. total time: 3.189s
  
rebooting into bootloader&#8230;
  
OKAY [ 0.007s]
  
finished. total time: 0.007s
  
archive does not contain &#8216;boot.sig&#8217;
  
archive does not contain &#8216;recovery.sig&#8217;
  
archive does not contain &#8216;system.sig&#8217;
  
&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8211;
  
Bootloader Version&#8230;: PRIMELA03
  
Baseband Version&#8230;..: I9250XXLA2
  
Serial Number&#8230;&#8230;..: 014696C30501A01C
  
&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8211;
  
checking product&#8230;
  
OKAY [ 0.007s]
  
checking version-bootloader&#8230;
  
OKAY [ 0.008s]
  
checking version-baseband&#8230;
  
OKAY [ 0.008s]
  
sending &#8216;boot&#8217; (4148 KB)&#8230;
  
OKAY [ 0.655s]
  
writing &#8216;boot&#8217;&#8230;
  
OKAY [ 0.254s]
  
sending &#8216;recovery&#8217; (4478 KB)&#8230;
  
OKAY [ 0.671s]
  
writing &#8216;recovery&#8217;&#8230;
  
OKAY [ 0.520s]
  
sending &#8216;system&#8217; (316111 KB)&#8230;
  
OKAY [ 35.767s]
  
writing &#8216;system&#8217;&#8230;
  
OKAY [ 34.853s]
  
erasing &#8216;userdata&#8217;&#8230;
  
OKAY [ 0.611s]
  
erasing &#8216;cache&#8217;&#8230;
  
OKAY [ 0.013s]
  
rebooting&#8230;

finished. total time: 73.403s
  
[/bash]

これで導入完了。あとは再起動するだけだ。 

## システムアップデート

Android 4.0.4で起動するので、システムアップデートを行う。これで、Android 4.1に更新される。
  
[<img src="/blog/uploads/2012/07/Android41Egg.png" alt="" title="Android41Egg" width="338" height="601" class="alignnone size-full wp-image-1685" srcset="/blog/uploads/2012/07/Android41Egg.png 338w, /blog/uploads/2012/07/Android41Egg-168x300.png 168w" sizes="(max-width: 338px) 100vw, 338px" />][10]
  
[<img src="/blog/uploads/2012/07/Android41Sys.png" alt="" title="Android41Sys" width="338" height="601" class="alignnone size-full wp-image-1686" srcset="/blog/uploads/2012/07/Android41Sys.png 338w, /blog/uploads/2012/07/Android41Sys-168x300.png 168w" sizes="(max-width: 338px) 100vw, 338px" />][11]

 [1]: /blog/uploads/2012/07/jb-new-logo.png
 [2]: http://juggly.cn/archives/65409.html
 [3]: http://d.hatena.ne.jp/Kazzz/20111204/p1
 [4]: http://androidlover.net/smartphone/galaxynexus/sc-04d-ukrom-install.html
 [5]: http://androidlover.net/smartphone/galaxynexus/sc-04d-radio-img-backup.html
 [6]: /blog/uploads/2012/07/GN_oemunlock.jpg
 [7]: http://forum.xda-developers.com/showthread.php?t=1357642
 [8]: /blog/uploads/2012/07/GN_CWM.jpg
 [9]: https://developers.google.com/android/nexus/images
 [10]: /blog/uploads/2012/07/Android41Egg.png
 [11]: /blog/uploads/2012/07/Android41Sys.png
