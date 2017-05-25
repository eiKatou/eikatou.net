---
title: iOS開発：アプリ起動後にログイン画面を表示する
author: eiKatou
type: post
date: 2012-07-05T10:48:14+00:00
url: /1640.html
archives:
  - 2012
tags:
  - Apple
  - Dev

---
iPhoneアプリでログイン画面を表示するにはどうすれば良いか？けっこう悩んでいたが、[Stack Overflow][1]先生に聞いたら、難なく回答が返ってきた。答えは、[ios &#8211; Perform Segue on ViewDidLoad &#8211; Stack Overflow][2]。 

<!--more-->

簡単に説明すると、起動直後はメイン画面を表示する。メイン画面を表示する前に、ログイン画面を表示する必要があればログイン画面を表示する。
  
[<img src="http://eikatou.net/blog/wp-content/blog/uploads/2012/07/20120705a.png" alt="" title="20120705a" width="263" height="375" class="alignnone size-full wp-image-1641" srcset="/uploads/2012/07/20120705a.png 263w, /blog/uploads/2012/07/20120705a-210x300.png 210w" sizes="(max-width: 263px) 100vw, 263px" />][3]
  
上の画像のように、Login画面のプロパティで、LoginViewControllerにIdentifierをつけおく。

MainControllerViewに書くコード。
  
[c]
  
&#8211; (void)viewWillAppear:(BOOL)animated {
      
if (![self hasLoginSettings]) {
          
[self showLoginView];
      
}

}

/*
   
* ログイン設定があるかを判定する。
   
*/
  
&#8211; (BOOL)hasLoginSettings {
      
return NO;
  
}

/*
   
* ログイン画面を表示する。
   
*/
  
&#8211; (void)showLoginView {
      
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
      
LoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
      
[vc setModalPresentationStyle:UIModalPresentationFullScreen];
      
vc.delegate = self;

[self presentModalViewController:vc animated:NO];
  
}

[/c]
  
メイン画面のviewWillAppearを使うと、メイン画面の表示前に呼び出せる。あと、Storyboard上では、MainViewからLoginViewへの線は引かなくても良い。

2012/08/12：追記
  
UITabBarControllerを利用すると、上記のコードでは動かなかった。UITabBarControllerでは、「(void)viewDidAppear:(BOOL)animated」に”showLoginView”を書くと動くようだ。

 [1]: http://stackoverflow.com/
 [2]: http://stackoverflow.com/questions/8221787/perform-segue-on-viewdidload
 [3]: http://eikatou.net/blog/wp-content/blog/uploads/2012/07/20120705a.png
