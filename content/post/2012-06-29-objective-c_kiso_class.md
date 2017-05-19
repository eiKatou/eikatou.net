---
title: Objective-Cの基礎（クラス定義）
author: eiKatou
type: post
date: 2012-06-29T11:44:57+00:00
url: /1595.html
categories:
  - Apple
  - Dev

---
Objective-Cを勉強し始めてから3ヵ月ぐらい経って、ようやく慣れてきた。しかし、基礎がなっていないためか、詰まることが多い。ということで、基礎から勉強をやり直すことにした。今回は、クラスの定義を勉強した。

ところで、Objective-Cには、&#8221;Modern&#8221;と&#8221;Legacy&#8221;があるらしい（参考：[プロパティに対応するインスタンス変数の命名規則について &#8211; Awaresoft][1]）。

私はこれで混乱していた。Objective-Cを解説したWebサイトごとに書き方が違うので、どれを参考にすれば良いのか分からなくなってしまった。今回は&#8221;Modern&#8221;な書き方で、一つのクラスを作成する時のひな形を用意した。

<!--more-->

## ヘッダーファイル

[c]
  
//
  
// MyClass.h
  
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject {

// private 変数
  
@private
      
int _a;
      
int _b;

// protected 変数
  
@protected
      
int _c;

// public 変数
  
@public
      
int _d;

}

// public property
  
@property (strong, nonatomic) NSString *name;

// public methods
  
-(void) say:(NSString *)message;

// public static methods
  
+(void) say:(NSString \*)name message:(NSString \*)message;

@end

[/c] 

変数を作る必要があるときは、ヘッダーファイルで定義する。変数の定義は、あまり使わないだろうと思う。プロパティにはpublicとprivateの両方があり、プロパティを利用するときは変数の定義は作成しなくてもよいからだ。とはいえ、覚えておこう。
  
あとは、publicなプロパティとメソッド、スタティックメソッドを定義する。

## .mファイル

[c]
  
//
  
// MyClass.m
  
// 

#import "MyClass.h"

@interface MyClass ()

// private property
  
@property int pri;

// private methods (as needed)
  
-(void) sayName;

@end

@implementation MyClass

// implementation of public and private methods.
  
@synthesize name = _name;
  
@synthesize pri = _pri;

&#8211; (id)init
  
{
      
if (self == [super init]) {
          
/\* initialization code \*/
          
self.name = @"Mimi";
          
_a = 1;
          
_b = 2;
          
_c = 3;
          
_d = 4;
          
_pri = 8;
      
}

return self;
  
}

&#8211; (void)dealloc
  
{
      
/\* alloc init したオブジェクトをreleaseする \*/
  
// [myData release];
  
}

-(void) say:(NSString *)message {
      
[self sayName];
      
NSLog(@"message:%@", message);
  
}

+(void) say:(NSString \*)name message:(NSString \*)message {
      
NSLog(@"name:%@", name);
      
NSLog(@"message:%@", message);
  
}

-(void) sayName {
      
NSLog(@"name:%@", self.name);
  
}

@end

[/c]

privateなプロパティやメソッドは、.mファイルで定義できる。
  
プロパティの宣言と同時に、アンダーバーつきの変数の宣言がおこなえる。アンダーバーつきの変数は、initメソッド、deallocメソッド、getter/setterで使う。

残念なことに、Objective-Cには、protectedなメソッドはないらしい。

* * *

今回のソースコードを元に作ったひな形。
  
[MyClass.zip][2]

 [1]: http://www.awaresoft.jp/ios-dev/item/115-ivar-naming-convention.html
 [2]: http://eikatou.net/blog/wp-content/uploads/2012/06/MyClass.zip
