---
title: Objective-Cの基礎（プロトコル定義）
author: eiKatou
type: post
date: 2012-06-30T01:24:30+00:00
url: /1607.html
categories:
  - Apple
  - Dev

---
プロトコルを勉強した。JavaでいうInterfaceにあたる。

プロトコルはインターフェースを定義するものだが、delegateと組み合わせて使われることも多い。なので、「通常のプロトコル」と「デリゲート＆プロトコル」のサンプルを作成してみた。

<!--more-->

## 通常のプロトコル

[objc]
  
//
  
// MyProtocol.h
  
//

#import <Foundation/Foundation.h>

@protocol MyProtocol <NSObject>

@required

-(void) foo1;

@optional

-(void) foo2;

@end

[/objc]
  
ヘッダーファイルにプロトコルを定義する。requiredは実装が必須なメソッド、optionalは実装を強要しないメソッドとなる。 

[objc]
  
//
  
// MyClass.h
  
//

#import <Foundation/Foundation.h>
  
#import "MyProtocol.h"

@interface MyClass : NSObject <MyProtocol>

// public methods
  
-(void) say;

@end

[/objc]
  
[objc]
  
//
  
// MyClass.m
  
//

#import "MyClass.h"

@implementation MyClass

-(void) say {
      
NSLog(@"call MyClass say");

[self foo1];
  
}

-(void) foo1 {
      
NSLog(@"call foo1");
  
}

-(void) foo2 {
      
NSLog(@"call foo2");
  
}

@end

[/objc]
  
クラスのヘッダーファイルで、MyProtocolを使用することを宣言して、メソッドを実装する。実装しないとコンパイル時に怒られる。 

JavaのInterfaceと同じような使い方が出来そうだ。

## デリゲート＆プロトコル

上記のサンプルに、新しいクラス（MyProtocol2）とプロトコル（MyProtocolDelegate）を追加した。

[c]
  
//
  
// MyProtocol2.h
  
//

#import <Foundation/Foundation.h>

@protocol MyProtocolDelegate <NSObject>

@required

-(void) hoge;

@end

@interface MyProtocol2 : NSObject

@property (weak) id<MyProtocolDelegate> delegate;

// public methods
  
-(void) say:(NSString *)message;

@end

[/c]

[c]
  
//
  
// MyProtocol2.m
  
//

#import "MyProtocol2.h"

@implementation MyProtocol2

@synthesize delegate = _delegate;

-(void) say:(NSString *)message {
      
NSLog(@"call say method. message:%@", message);

if(self.delegate != nil
         
&& [self.delegate conformsToProtocol:@protocol(MyProtocolDelegate)]) {
          
[self.delegate hoge];
      
}
  
}

@end

[/c]
  
クラスの宣言と同時に、プロトコルの宣言（MyProtocolDelegate）も行う。そして、Delegateを設定するためのプロパティを用意する。クラス内のメソッドから、delegateに設定されたhogeメソッドを呼び出している。 

[c]
  
//
  
// MyClass.h
  
//

#import <Foundation/Foundation.h>
  
#import "MyProtocol2.h"

@interface MyClass : NSObject <MyProtocolDelegate>

// public methods
  
-(void) say;

@end

[/c]
  
[c]
  
//
  
// MyClass.m
  
//

#import "MyClass.h"

@implementation MyClass

-(void) say {
      
NSLog(@"call MyClass say");

MyProtocol2 *myProtocol2 = [[MyProtocol2 alloc] init];
      
myProtocol2.delegate = self;
      
[myProtocol2 say:@"hello"];
  
}

-(void) hoge {
      
NSLog(@"call hoge");
  
}

@end

[/c]
  
こちらは、MyProtocol2を使う側のソース。MyProtocol2インスタンスのdelegateに、自分のインスタンス（self）を指定する。MyProtocol2インスタンスのメソッドを呼び出すと、MyProtocol2内部から、自身のhogeメソッドが呼び出される。Javaのコールバックのような使い方だ。 

デリゲート＆プロトコルは、TableViewなどで使われている。「TableViewが操作されたら、このメソッドを呼び出してね」という使い方だ。仕組みを知っていると、TableViewを利用する実装がスムーズに行えると思う。

* * *勉強に使ったソースコード。


  
[MyProtocol.zip][1]</p>

 [1]: http://eikatou.net/blog/wp-content/uploads/2012/06/MyProtocol.zip
