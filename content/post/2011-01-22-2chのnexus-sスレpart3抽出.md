---
title: 2chのNexus Sスレ(Part3)抽出
author: eiKatou
type: post
date: 2011-01-22T12:55:59+00:00
url: /57.html
archives:
  - 2011
tags:
  - Android

---
<div class="section">
  <p>
    <a href="http://f.hatena.ne.jp/Sirokoix/20110103182940" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/S/Sirokoix/20110103/20110103182940.png" alt="f:id:Sirokoix:20110103182940p:image:w200" title="f:id:Sirokoix:20110103182940p:image:w200" class="hatena-fotolife" width="200" /></a>
  </p>
  
  <p>
    役に立ちそうなレスを抽出しました。
  </p>
  
  <p>
    <a href="http://hibari.2ch.net/test/read.cgi/smartphone/1294978557/" target="_blank">【Google】Nexus S【Samsung】Part3</a>
  </p>
  
  <pre>
95 ：名無しさん＠お腹いっぱい。：2011/01/18(火) 11:18:44 ID:tRswPRXH
次に2:40秒君が来たらこれ貼ってやってくれ。
xdaに投稿されたbrowserlag問題解消法
1. ブラウザのアドレス欄開く
2. &#34;about:debug&#34;と入力し移動
3. 設定にdebug項目が追加されるので&#34;Normal Rendering&#34;をON
4. サクサク動作
ちなみにこれは標準ブラウザを使ってる場合の対処法で
xScopeなんかだと特にカクついたりしないね。
あとこの現象は俺の知る限りGalaxy Tabでも起きてた。
277 ：名無しさん＠お腹いっぱい。：2011/01/24(月) 11:17:13 ID:l6tuVyR5
2.3.2
ttp://android.clients.google.com/packages/ota/google_crespo/
353e267378cd.signed-soju-GRH78C-from-GRH78.353e2673.zip
update.zipにリネームしてRecoveryで適用させればOK。
当たり前だけどカスタム入れてるとmd5でこけるから注意な。
297 ：名無しさん＠お腹いっぱい。：2011/01/25(火) 15:25:46 ID:dorvkuLP
superbootでroot取得してリカバリーもcwに変更しましたが、
277からダウンロードしてupdate.zipにリネーム、cwのリカバリで
update.zipを適用したら無事232になったよ。やり方違うんかな～
298 ：名無しさん＠お腹いっぱい。：2011/01/25(火) 15:52:01 ID:AR2RoDug
まずCM使ってる奴は純正2.3.1ROMに戻せ。
んで2.3.2のzip落としてリカバリはClockworkModのままで良いから
install zip from sdcardからupdate.zip適用しろ。
OTAやapplay updateで直接アプデしようとしても無理だからな。
321 ：名無しさん＠お腹いっぱい。：2011/01/27(木) 23:58:36 ID:NiZQwpzq
Nexus S を最新バージョンにしたら、android Marketでprotectedなアプリが表示されなくなりました。
これって解決する方法はあるのでしょうか？
322 ：名無しさん＠お腹いっぱい。：2011/01/28(金) 01:28:22 ID:jyp01Kjz
&#62;&#62;321
rootとって/system/build.propのro.build.fingerprintforcheckinの値を
google/soju/crespo:2.3.1/GRH78/85442:user/release-keysに書き換える。
375 ：名無しさん＠お腹いっぱい。：2011/01/31(月) 15:18:49 ID:lA8v+75B
そういやandroid2.3ってデュアルコアに最適化されてるの？
376 ：名無しさん＠お腹いっぱい。：2011/01/31(月) 17:06:47 ID:J2VkgzS8
&#62;&#62;375
最適化はされてないと思うが2.3で採用されたコンカレントGCはマルチコアに有利。
377 ：名無しさん＠お腹いっぱい。：2011/01/31(月) 17:50:36 ID:q5rUMaa+
最適化が何を指すかにもよるが、カーネルは余裕でSMP対応
dalvikのThreadはnative threadなのでアプリがThread使って書かれていればマルチコア対応になる
ただ&#62;&#62;376の言うとおり2.2までGCがプロセスブロックしてシングルスレッドだったので
2.3で採用されたコンカレントGCでマルチコア対応がより強化されたりはしてる
Google公式では、2.3はデュアルコアまで最適化、3.0からマルチコアに最適化とされているので
フレームワーク部分の例えばUIスレッド周りが内部でマルチスレッド化されたとかはあるかもね
マルチコアに最適化って言葉自体は割とバズワードだ
408 ：名無しさん＠お腹いっぱい。：2011/02/03(木) 00:02:44 ID:7P+000Mx
ext4最適化を質問したけど、だれも答えてくれないので自分いろいろやってみました。
ext4とnexus Sでググルとこんなページが
ttp://forum.xda-developers.com/showthread.php?t=876069
どうやらmount -o remount,noauto_da_alloc /data /dataをしてやればいいらしい。
でも起動時に自動的にそれをやらせる方法がないかとググルと
ttp://www.gcd.org/blog/2010/10/658/
こんなページが見つかった。
というわけで合わせ技でやったのが、これ。
/system/etc/install-recovery.shを編集して
mount -o remount,noauto_da_alloc /data /data
exit 0
という行を文頭に足してやった。
結果ものすごくspeed upした。scoreで約800ぐらい上がった。
434 ：名無しさん＠お腹いっぱい。：2011/02/05(土) 01:34:36 ID:nsUA/Mw7
ソフトバンクのガラケーで、海外でローミング中、
発信ができるけど着信が一切できない状況になった。
東京の窓口に聞いたら、ローミング先事業者を変更しろ、と。
変更してもダメ。
電源off→onで復活した。
ってことがあった。
442 ：名無しさん＠お腹いっぱい。：2011/02/05(土) 17:45:22 ID:nt8+HC3K
とりあえずwifiオンリーで運用、&#42;#&#42;#4636#&#42;#&#42;でWCDMA Onlyに設定して運用中。
今のところ着信不具合はないっぽい。
459 ：名無しさん＠お腹いっぱい。：2011/02/06(日) 19:54:05 ID:jpl8roH6
SKINOMIフィルムいいよ。
フェイクなカーボンファイバー柄だけど、大きさが変わらないのがイイ。一緒にディスプレイ保護フィルムもついてくるし。
俺手が小さいもんで、カバーつけるとデカ過ぎてキツイ。
461 ：名無しさん＠お腹いっぱい。：2011/02/06(日) 20:48:21 ID:0WQsx2pV
&#62;&#62;459
そういや購入報告があったな。
是非装着のしやすさ等のレビューと写真のアップを頼む。
xdaだと難しい的な？書き込みがあったし。
今おれはTPUケース使ってるが、N1にケースつけたときと違って大きさを感じない。なんでだろ？
462 ：名無しさん＠お腹いっぱい。：2011/02/06(日) 21:06:20 ID:7kOHzWJf
talkingSIMで時々電波が白くなって通信できない時は、Androidマーケットを起動して何度かリロードすると復旧するっぽい。
もっと根本的な直し方あるんだろうけど…
464 ：名無しさん＠お腹いっぱい。：2011/02/06(日) 22:31:19 ID:lj0Ij0Ze
&#62;&#62;461
水で薄めた中性洗剤が一緒に入ってるんだけど、それ使わないと絶望的に無理。
一発で貼るのは不可能。
でも付けると今度は滑りまくる。
カーボンフィルムの硬度で反り上がって全然引っ付かない。
なのでドライヤーでカーボンフィルム柔らかくして乾かしつつつけたらなんとか行けた。
デフォより滑りやすくなってちょいデンジャーだけど、
かっこよさは抜群って感じかな。
551 ：名無しさん＠お腹いっぱい。：2011/02/11(金) 12:44:15 ID:r1A2MJtM
なんか/sdcardにradio_dump_YYYYMMDDHHmmss.binみたいなファイルがいくつかあったんだけど、
これなんだろ。どれも37MBある
554 ：名無しさん＠お腹いっぱい。：2011/02/11(金) 18:58:13 ID:W6e9shQL
&#62;&#62;551
clockworkmod recoveryで何かしらzipファイルを適用するとできるんじゃないかな。
</pre>
</div>
