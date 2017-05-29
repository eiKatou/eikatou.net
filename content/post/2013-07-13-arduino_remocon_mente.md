---
title: Arduinoで創るネットワーク対応リモコン（メンテナンス）
author: eiKatou
type: post
date: 2013-07-13T09:05:45+00:00
url: /2954.html
archives:
  - 2013
tags:
  - Arduino

---
[Arduinoで創るネットワーク対応リモコン（完成！）][1]でリモコン操作デバイスを作っていた。今夏も活躍を期待していたのだが、動かなくなっていた。
  
まさか、一年の寿命だったのか・・と落胆しつつデバッグしてみると、Dropboxの共有ファイルの取得に失敗しているようであった。ソフトウェアの問題で良かった。

HTTPリクエストを投げるときに、Hostを指定してあげると取得できるようになった。

```c
  
client.println("GET " + String(urlPath) + " HTTP/1.0");
  
client.println("Host: dl.dropboxusercontent.com");
  
client.println();
  
```

## 思ったこと

ちょっと手を抜いていたところで、こういう問題が出てしまった。「手抜きすると、後で何倍も時間がかかることになる」と思った。手の抜きどころって難しい。

 [1]: /tags/arduino/
