---
title: Nexus Sをroot化
author: eiKatou
type: post
date: 2011-01-23T02:33:09+00:00
url: /58.html
tags:
  - Android

---
<div class="section">
  <p>
    Nexus Sを買いました。
  </p>
  
  <p>
    <a href="http://f.hatena.ne.jp/Sirokoix/20110123110518" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/S/Sirokoix/20110123/20110123110518.jpg" alt="f:id:Sirokoix:20110123110518j:image" title="f:id:Sirokoix:20110123110518j:image" class="hatena-fotolife" /></a>
  </p>
  
  <p>
    とりあえず、rootをとりました。
  </p>
  
  <p>
    root化などの改造は、全て自己責任で実行しましょう。動かなくなっても誰も助けてくれません。
  </p>
  
  <p>
    <a href="http://f.hatena.ne.jp/Sirokoix/20110123113259" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/S/Sirokoix/20110123/20110123113259.jpg" alt="f:id:Sirokoix:20110123113259j:image" title="f:id:Sirokoix:20110123113259j:image" class="hatena-fotolife" /></a>
  </p>
  
  <p>
    やり方は2パターンあります。1パターン目はsuをリカバリからインストールする方法。2パターン目はsuperbootを使用する方法<span class="footnote"><a href="/Sirokoix/#f1" name="fn1" title="superbootを使用すると、boot.imgが書き換えられるのでOTAアップデートに失敗します。標準ROMで使いつづけるなら、superbootでなく、上記サイトのやりかたの方がいいでしょう。">*1</a></span>。
  </p>
  
  <p>
    私は1パターン目を実行しました。以下のサイトを参考にしました。
  </p>
  
  <ul>
    <li>
      <a href="http://d.hatena.ne.jp/Kazzz/20110108/p1" target="_blank"> Nexus Sのroot取得 その1 (デバイスドライバ導入～oem unlockまで) &#8211; Kazzzの日記</a>
    </li>
    <li>
      <a href="http://d.hatena.ne.jp/Kazzz/20110109/p1" target="_blank"> Nexus Sのroot取得 その2 (clockworkMod Recovery導入～root取得まで?) &#8211; Kazzzの日記</a>
    </li>
    <li>
      <a href="http://d.hatena.ne.jp/Kazzz/20110110/p1" target="_blank"> Nexus Sのroot取得 その3 (suとSuperUser.apkのインストール) &#8211; Kazzzの日記</a>
    </li>
  </ul>
  
  <p>
    ハマったところを書きます。PCの環境はDebian Lennyです。
  </p>
  
  <h4>
    Nexus Sを認識しません
  </h4>
  
  <p>
    1./etc/udev/rules.d/51-android.rulesに以下を追記。
  </p>
  
  <blockquote>
    <p>
      UBSYSTEM==&#8221;usb&#8221;, SYSFS{idVendor}==&#8221;04e8&#8243;, MODE=&#8221;0666&#8243;
    </p>
    
    <p>
      UBSYSTEM==&#8221;usb_devices&#8221;, SYSFS{idVendor}==&#8221;04e8&#8243;, MODE=&#8221;0666&#8243;
    </p>
  </blockquote>
  
  <p>
    udevをリスタート。
  </p>
  
  <pre class="syntax-highlight">
<span class="synComment"># /etc/init.d/udev restart</span>
</pre>
  
  <p>
    2.USB debuggingを有効にする
  </p>
  
  <p>
    (ここでUSBで繋げば認識するはず、、だったけど認識してくれなかった)
  </p>
  
  <p>
    3.adb serverを再起動すれば良いらしい
  </p>
  
  <pre class="syntax-highlight">
$ adb <span class="synStatement">kill</span>-server
$ sudo adb <span class="synStatement">start</span>-server
$ adb devices
</pre>
  
  <h4>
    fastbootコマンドどこ？
  </h4>
  
  <p>
    他のサイトではfastbootコマンドを使って、oem unlockしている。でもそのfastbootコマンドはどこに？
  </p>
  
  <p>
    以下のサイトのリンク先から落として、パスが通っている場所に置くらしい。
  </p>
  
  <ul>
    <li>
      <a href="http://forum.xda-developers.com/showthread.php?t=657839" target="_blank"> How To Install The Android Sdk and Adb and Fastboot in Linux &#8211; xda-developers</a>
    </li>
  </ul>
  
  <p>
    devicesオプションで確認しておくと良いです。
  </p>
  
  <pre class="syntax-highlight">
<span class="synComment"># ./fastboot devices</span>
353205ACDF4600EC	fastboot
<span class="synComment"># ./fastboot oem unlock</span>
... OKAY
</pre>
  
  <h4>
    非root化するには
  </h4>
  
  <p>
    Clockwork recoveryを使ってnandbackupのイメージを入れます。以下の方法でunroot出来ました。
  </p>
  
  <ul>
    <li>
      <a href="http://forum.xda-developers.com/showthread.php?t=884093" target="_blank"> &#91;ROM&#93; &#91;NANDROID BACKUP&#93; Stock GRH78 for Nexus S Android 2.3.1 &#8211; xda-developers</a>
    </li>
    <li>
      <a href="http://theunlockr.com/2011/01/20/how-to-unroot-the-nexus-s/" target="_blank">How To: Unroot the Nexus S | TheUnlockr</a>
    </li>
  </ul>
  
  <h4>
    参考サイト
  </h4>
  
  <ul>
    <li>
      <a href="http://juggly.cn/archives/14828.html" target="_blank">Nexus Sのブートローダーのアンロック、root化、Clockworkリカバリ、busybox導入手順（更新） | juggly.cn</a>
    </li>
    <li>
      <a href="http://d.hatena.ne.jp/Kazzz/20110108/p1" target="_blank"> Nexus Sのroot取得 その1 (デバイスドライバ導入～oem unlockまで) &#8211; Kazzzの日記</a>
    </li>
    <li>
      <a href="http://d.hatena.ne.jp/Kazzz/20110109/p1" target="_blank"> Nexus Sのroot取得 その2 (clockworkMod Recovery導入～root取得まで?) &#8211; Kazzzの日記</a>
    </li>
    <li>
      <a href="http://d.hatena.ne.jp/Kazzz/20110110/p1" target="_blank"> Nexus Sのroot取得 その3 (suとSuperUser.apkのインストール) &#8211; Kazzzの日記</a>
    </li>
    <li>
      <a href="http://d.hatena.ne.jp/emergent/20100228/1267334766" target="_blank">Dev PhoneにUbuntuマシンから接続しようとしたら'error: insufficient permissions for device'などと怒られるときの対処法 &#8211; にたまごほうれん草</a>
    </li>
  </ul>
</div>

<div class="footnote">
  <p class="footnote">
    <a href="/Sirokoix/#fn1" name="f1">*1</a>：superbootを使用すると、boot.imgが書き換えられるのでOTAアップデートに失敗します。標準ROMで使いつづけるなら、superbootでなく、上記サイトのやりかたの方がいいでしょう。
  </p>
</div>
