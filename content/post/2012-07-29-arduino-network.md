---
title: Arduinoでネットワークアクセス
author: eiKatou
type: post
date: 2012-07-29T13:55:52+00:00
url: /1760.html
archives:
  - 2012
tags:
  - Arduino
  - Dev

---
Arduinoでネットワークへの接続を行った。せっかくEthernet端子付きのArduinoを買ったんだから、試してみないとね。

以下の３つを試してみた。

  1. IPアドレス(Google)へ接続
  2. URL(Dropbox)へ接続
  3. 一定時間おきに接続

<!--more-->

## IPアドレス(Google)へ接続

Googleへのアクセスを行う。

サンプルのMACアドレスと、GoogleのIPアドレスを変更して動かしてみた。MACアドレスは、Arduinoの裏面にシールで貼ってある。IPアドレスは、[IPドメインLOOKUP][1]で、「google.com」で調べると良い。

[c]
  
#include <SPI.h>
  
#include <Ethernet.h>

byte mac[] = { 0x90,0xA2, 0xDA, 0x0D, 0x27, 0xBE };
  
IPAddress server(74,125,235,66); // Google
  
EthernetClient client;

void setup() {
    
Serial.begin(9600);
     
while (!Serial) {
      
;
    
}

if (Ethernet.begin(mac) == 0) {
      
Serial.println("Failed to configure Ethernet using DHCP");
      
for(;;)
        
;
    
}
    
delay(1000);
    
Serial.println("connecting&#8230;");

if (client.connect(server, 80)) {
      
Serial.println("connected");
      
client.println("GET /search?q=arduino HTTP/1.0");
      
client.println();
    
}
    
else {
      
Serial.println("connection failed");
    
}
  
}

void loop()
  
{
    
if (client.available()) {
      
char c = client.read();
      
Serial.print(c);
    
}

if (!client.connected()) {
      
Serial.println();
      
Serial.println("disconnecting.");
      
client.stop();

for(;;)
        
;
    
}
  
}
  
[/c]
  
setupで接続を開始して、loopで戻り値を取得している。”client.read()”で、HTTPのレスポンスが読めるみたいだ。 

[<img src="http://eikatou.net/blog/wp-content/uploads/2012/07/google.png" alt="" title="arduino_network_google" width="754" height="466" class="alignnone size-full wp-image-1763" srcset="/uploads/2012/07/google.png 754w, /uploads/2012/07/google-300x185.png 300w, /uploads/2012/07/google-485x300.png 485w" sizes="(max-width: 754px) 100vw, 754px" />][2]
  
結果がHTMLで返ってくる。HTMLの出力には、それなりに時間がかかった。 

## URL(Dropbox)へ接続

今度は、Dropboxの公開フォルダに置いたファイルを参照しに行く。先ほどと違うのは、ドメイン名を指定している点。IPアドレスは変わるかもしれないので、ドメイン名で指定した方が良い。

[c]
  
#include <SPI.h>
  
#include <Ethernet.h>

byte mac[] = { 0x90,0xA2, 0xDA, 0x0D, 0x27, 0xBE };
  
IPAddress server(74,125,235,66); // Google
  
char serverName[] = "dl.dropbox.com";
  
EthernetClient client;

void setup() {
    
Serial.begin(9600);
     
while (!Serial) {
      
;
    
}

if (Ethernet.begin(mac) == 0) {
      
Serial.println("Failed to configure Ethernet using DHCP");
      
for(;;)
        
;
    
}
    
delay(1000);
    
Serial.println("connecting&#8230;");

if (client.connect(serverName, 80)) {
      
Serial.println("connected");
      
client.println("GET /u/7551322/hello.txt HTTP/1.0");
      
client.println();
    
}
    
else {
      
Serial.println("connection failed");
    
}
  
}

void loop()
  
{
    
if (client.available()) {
      
char c = client.read();
      
Serial.print(c);
    
}

if (!client.connected()) {
      
Serial.println();
      
Serial.println("disconnecting.");
      
client.stop();

for(;;)
        
;
    
}
  
}
  
[/c]
  
IPアドレスをドメイン名に変えて、hello.txtまでのパスを書いた。そこの違いだけで、それ以外は同じ。 

[<img src="http://eikatou.net/blog/wp-content/uploads/2012/07/dropbox.png" alt="" title="arduino_network_dropbox" width="754" height="531" class="alignnone size-full wp-image-1762" srcset="/uploads/2012/07/dropbox.png 754w, /uploads/2012/07/dropbox-300x211.png 300w, /uploads/2012/07/dropbox-425x300.png 425w" sizes="(max-width: 754px) 100vw, 754px" />][3]
  
ドメイン名を指定して、接続できていた。最後に出力されている”Hello Network”は、hello.txtの中身だ。 

## 一定時間おきに接続

次は、一定時間おきにネットワーク接続を行う。実際の運用になると、数分おきにネットワーク接続する事になるだろう。一定時間おきに、Dropboxのファイルを参照するプログラムを書いた。

[c]
  
#include <SPI.h>
  
#include <Ethernet.h>

#define LED_PIN 9

#define MODE_CONNECT 1
  
#define MODE_ALLREADED 2
  
#define MODE_DISCONNECT 3

byte mac[] = { 0x90,0xA2, 0xDA, 0x0D, 0x27, 0xBE };
  
char serverName[] = "dl.dropbox.com";
  
EthernetClient client;
  
int mode = MODE_DISCONNECT;

void setup() {
    
pinMode(LED_PIN, OUTPUT);

Serial.begin(9600);
     
while (!Serial) {
      
;
    
}

if (Ethernet.begin(mac) == 0) {
      
Serial.println("Failed to configure Ethernet using DHCP");
      
for(;;)
        
;
    
}

delay(1000);
    
Serial.println("ready.");
    
Serial.println();
  
}

void loop()
  
{
    
if (mode == MODE_CONNECT) {
      
if (client.available()) {
        
char c = client.read();
        
Serial.print(c);

if (c == &#8216;$&#8217;){
          
mode = MODE_ALLREADED;
        
}
      
}
    
}

if (mode == MODE_DISCONNECT) {
      
Serial.println("connecting&#8230;");
      
mode = MODE_CONNECT;
      
digitalWrite(LED_PIN, HIGH);

if (client.connect(serverName, 80)) {
        
Serial.println("connected");
        
Serial.println();
        
client.println("GET /u/7551322/hello.txt HTTP/1.0");
        
client.println();
      
} else {
        
Serial.println("connection failed");
      
}
    
}

if (mode == MODE_ALLREADED || !client.connected()) {
      
Serial.println();
      
Serial.println("disconnecting.");
      
Serial.println();
      
Serial.println();
      
client.stop();
      
digitalWrite(LED_PIN, LOW);
      
delay(5000);
      
mode = MODE_DISCONNECT;
    
}
  
}
  
[/c]
  
ここは少しポイントがある。loopでネットワーク接続を行うため、接続中などのステータス管理を実施する必要がある。ここでは、3つのステータスを導入している。それぞれのステータスの箇所が動く仕組みだ。
  
MODE_CONNECTのif文で、”if (c == &#8216;$&#8217;)”としている箇所がある。これは、textの最後を判別するために用意した。Dropboxのhello.txtの最後に”$”を入れている。これがないと、読み込み終了判定が出来ないからだ。

＊2012/08/01 追記
  
”$”で読み込み終了判定をしていたが、[Arduino &#8211; ClientRead][4]によると、戻り値が-1かどうかで判定が出来るようだ。 

[<img src="http://eikatou.net/blog/wp-content/uploads/2012/07/loopAccess.png" alt="" title="arduino_network_loopAccess" width="754" height="607" class="alignnone size-full wp-image-1761" srcset="/uploads/2012/07/loopAccess.png 754w, /uploads/2012/07/loopAccess-300x241.png 300w, /uploads/2012/07/loopAccess-372x300.png 372w" sizes="(max-width: 754px) 100vw, 754px" />][5]
  
5秒おきに、ネットワーク接続を行っているのを確認した。hello.txtの中身を変えると、その変更が反映されたテキストが出力されることも確認した。

 [1]: http://www.mse.co.jp/ip_domain/lookup.shtml
 [2]: http://eikatou.net/blog/wp-content/uploads/2012/07/google.png
 [3]: http://eikatou.net/blog/wp-content/uploads/2012/07/dropbox.png
 [4]: http://arduino.cc/it/Reference/ClientRead
 [5]: http://eikatou.net/blog/wp-content/uploads/2012/07/loopAccess.png
