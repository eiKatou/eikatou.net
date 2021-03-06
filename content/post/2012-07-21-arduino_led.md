---
title: ArduinoでLEDを光らせる
author: eiKatou
type: post
date: 2012-07-21T02:51:02+00:00
url: /1699.html
archives:
  - 2012
tags:
  - Arduino
  - Dev

---
ArduinoでLEDを光らせてみた。プログラミングでいうところの「Hello World!」だ。

![_](/uploads/2012/07/Arduino_led0.jpg)
  
LEDを光らせるために、いろいろとお買い物もした。送料込みで2,050円也。

  * ブレッドボード
  * ジャンプワイヤーキット
  * LED 赤
  * カーボン抵抗 1/4W 150ohm

高い・・。日本橋に買いに行った方が良いかも、と思った。 

<!--more-->

## 内蔵LEDを光らせる

内蔵のLEDもあるので、まずは内蔵LEDで挑戦。サンプルのコードは13番ピンを指定しているが、Arduino Ethernetは9番ピンを指定する。
  
```c  
// Pin 13 has an LED connected on most Arduino boards.
// give it a name:
int led = 9;

// the setup routine runs once when you press reset:
void setup() {
  // initialize the digital pin as an output.
  pinMode(led, OUTPUT);
}

// the loop routine runs over and over again forever:
void loop() {
  digitalWrite(led, HIGH); // turn the LED on (HIGH is the voltage level)
  delay(500); // wait for a second
  digitalWrite(led, LOW); // turn the LED off by making the voltage LOW
  delay(2000); // wait for a second
}
```

![_](/uploads/2012/07/Arduino_led1.jpg)
  
手前の小さなLED（緑）が光っている。左のLEDが9番ピンでの制御になっていて、点滅している。 

## LEDを光らせる

次は、Arduinoから電力供給して、LEDを光らせる。プログラミングは不要だが、配線を行う必要がある。久しぶり（9年ぶり）の配線で、かなり緊張した。
  
![_](/uploads/2012/07/Arduino_led2.jpg)
  
どうだっ！ [5V電源] &#8211; [抵抗（150ohm）] &#8211; [LED] &#8211; [GND]と繋いでいる。 

## LEDを光らせて制御する

最後は、LEDをプログラムから制御する。さっきは電源から繋いでいたが、今度は6番ピンと9番ピンから繋ぐ。6番ピンと9番ピンは、パルス幅変調（PWM）に対応しているので、明るさを制御することが出来る。

```c  
int led1 = 6;
int led2 = 9;
void setup() {
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
}

void loop() {
  for (int i=0; i<256; i++) {
    analogWrite(led1, i);
    analogWrite(led2, 255-i);
    delay(10);
  }
  delay(1000);

  for (int i=0; i<256; i++) {
    analogWrite(led1, 255-i);
    analogWrite(led2, i);
    delay(10);
  }
  delay(1000);
  
}
```
  
明るさを制御するには、analogWrite関数を使用する。第1引数がピン番号で、第2引数が出力(min 0 〜 max 255)だ。このプログラムを動かすと、6番ピンのLEDが明るくなっていき、9番ピンのLEDが暗くなっていく。その後、1秒停止して、6番ピンは暗く、9番ピンは明るくなる。

![_](/uploads/2012/07/Arduino_led3.jpg)
  
両方のLEDの明るさが徐々に変化していくのが確認できた。

 [1]: /uploads/2012/07/Arduino_led0.jpg
 [2]: /uploads/2012/07/Arduino_led1.jpg
 [3]: /uploads/2012/07/Arduino_led2.jpg
 [4]: /uploads/2012/07/Arduino_led3.jpg
