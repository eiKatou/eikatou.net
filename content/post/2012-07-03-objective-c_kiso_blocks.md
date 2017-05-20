---
title: Objective-Cの基礎（Blocks）
author: eiKatou
type: post
date: 2012-07-03T14:30:06+00:00
url: /1626.html
archives:
  - 2012
tags:
  - Apple
  - Dev

---
Blocksを勉強した。Blocksは、一般的にはクロージャと呼ばれている物らしい。クロージャというのは、今まで一度も触ったことがなかったので、Objective-Cで始めて勉強した。

以下は、参考にさせていただいたサイト。

  * [C/Objective-C + Blocks でクロージャ &#8211; TrashSUITE][1]
  * [こたつつきみかん » Objective-C Blocks を使ってみる 1][2]
  * [GCDを試してみる &#8211; As Sloth As Possible][3]

<!--more-->

## 宣言 > 代入 > 実行

[c]
  
// 宣言する
  
void (^b0)();
  
// 代入する
  
b0 = ^() {
      
NSLog(@"block0.");
  
};
  
// 実行する
  
b0();
  
[/c]
  
”戻り値 (^名前)(引数)”の形で、Blockの変数を宣言する。”b0”が名前で、戻り値はvoid、引数はなし。それに、関数の代入を行う。関数ポインタと同じ使い方。”^()”のように名前は省略できる。引数はないので”()”のみとなる。実行は、普通のメソッドと同じ。

## 宣言 & 代入 > 実行

[c]
  
// 宣言して代入する
  
void (^b1)() = ^() {
      
NSLog(@"block1.");
  
};
  
// 実行する
  
b1();
  
[/c]
  
こちらは、宣言と同時に、代入している。 

## 実行のみ

[c]
  
// 実行する
  
^() {
      
NSLog(@"block2.");
  
}();
  
[/c]
  
関数を定義して、すぐに実行している。 

## 複数の引数をとるBlock

[c]
  
void (^add)(int x, int y) = ^(int x, int y) {
      
NSLog(@"%d + %d = %d", x, y, x+y);
  
};
  
add(1, 2);
  
[/c]
  
これは、引数をとる場合の例。 

## 型定義してシンプルに利用する

[c]
  
typedef int (^Add)(int x, int y);

int main(int argc, const char * argv[])
  
{
          
Add add2 = ^(int x, int y) {
              
return x + y;
          
};
          
int result = add2(10, 2);
          
NSLog(@"result = %d", result);
  
}
  
[/c]
  
typedefを使って型定義を行っている。typedefで、Addという型を定義している。Addは、”int (^)(int x, int y)”の型名となる。型定義を使えば、よりシンプルに書くことが出来る。
  
戻り値がintなので、値をreturnしている。 

## メソッドの引数にBlockをとる

[c]
  
@implementation MyClass

-(int) calc:(int(^)(int a, int b))process x:(int)x y:(int)y {
      
return process(x, y);
  
}

-(void)call {
      
// 関数を定義して利用
      
int result = [self calc:^int(int a, int b) {
          
return (a + b) / 2;
      
} x:10 y:20];

NSLog(@"result = %d", result);

// 関数を宣言して代入してから利用する
      
int(^process)(int a, int b);
      
process = ^(int a, int b) {
          
return a + b;
      
};
      
int result2 = [self calc:process x:10 y:20];
      
NSLog(@"result2 = %d", result2);
  
}

@end

[/c]
  
メソッドの引数にBlockを入れる。この利用方法をよく見かける。calcメソッドの定義が、わけわからん感じになっているが、”int(^)(int a, int b)”が型であることに注目すると読み解ける。
  
利用する方は、Xcodeの補完があるので、簡単に書くことが出来る。 

* * *

今回のサンプルソースコード。
  
[Sample_Blocks.zip][4]

 [1]: http://d.hatena.ne.jp/trashsuite/20100414/1271252150
 [2]: http://www.lifeaether.com/overtaker/blog/?p=1122
 [3]: http://blog.livedoor.jp/faulist/archives/1471730.html
 [4]: http://eikatou.net/blog/wp-content/blog/uploads/2012/07/Sample_Blocks.zip
