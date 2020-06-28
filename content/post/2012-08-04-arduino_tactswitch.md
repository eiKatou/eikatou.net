---
title: Arduinoでユーザ入力を読み取り（タクトスイッチ）
author: eiKatou
type: post
date: 2012-08-04T14:05:43+00:00
url: /1821.html
archives:
  - 2012
tags:
  - Arduino
  - Dev

---
![_](/uploads/2012/08/tactswitch1.jpg)
  
今日は、タクトスイッチでユーザの入力を取得できるようにした。タクトスイッチは、押すと回路が繋がるスイッチ。Arduinoと繋げて、タクトスイッチが押されている間は、LEDを光らせるようなプログラムを書いた。

<!--more-->

## タクトスイッチの入力を読み取る

まずは配線する。プルアップ抵抗をいれる（参考：[センサ道場 第４回 「プルアップ・プルダウン抵抗」][2]）。
  
![_](/uploads/2012/08/tactSwitch.jpg)

読み取りは２番ピンを使用した。ほぼ、サンプルのままなんだけど・・・
  
```c
const int buttonPin = 2; // the number of the pushbutton pin
const int ledPin = 9; // the number of the LED pin
int buttonState = 0;

void setup() {
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT);
}

void loop() {
  buttonState = digitalRead(buttonPin);
  if (buttonState == LOW) {
    // turn LED on:
    digitalWrite(ledPin, HIGH);
  } else {
    // turn LED off:
    digitalWrite(ledPin, LOW);
  }
}

```

ボタンを押している間は、Arduino上のLEDが光っていた。

## タクトスイッチで繋がるところ

間違って配線してしまっていた。4本足の差し方は、こう写真のように！
  
![_](/uploads/2012/08/tactswitch2.jpg)

* * *

目的の「Arduinoで創るネットワーク対応リモコン」まで、あと少しだ。タクトスイッチは、赤外線送信のテスト用ボタンとして用意する予定。

 [1]: /uploads/2012/08/tactswitch1.jpg
 [2]: http://www.netdecheck.com/coffee_break/dojyo/004/index.html
 [3]: /uploads/2012/08/tactSwitch.jpg
 [4]: /uploads/2012/08/tactswitch2.jpg
