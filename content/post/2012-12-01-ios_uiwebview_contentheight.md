---
title: iOS開発：UIWebViewで表示しているコンテンツの高さを取得
author: eiKatou
type: post
date: 2012-12-01T06:07:29+00:00
url: /2150.html
tags:
  - Apple
  - Dev

---
UIWebViewで表示しているコンテンツの高さを取得する。Webでやり方を検索していると、2通りのやり方が見つかる。

1つ目は、「document.documentElement.clientHeight;」を使うやり方。
  
2つ目は、「document.getElementById(\&#8221;contentsDiv\&#8221;).clientHeight;」を使用するやり方。

どっちが良いのか分からずに、1つ目のやり方を使っていた。しかし、いろいろと検証した結果、2つ目のやり方の方が良いように思った。

## 検証結果

1つ目のやり方の問題点は、コンポネント（UIWebView）の高さを取得してしまう事がある点だ。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121201b.jpg" alt="" title="20121201b" width="170" height="250" class="alignnone size-full wp-image-2152" />][1]
  
上の画像のように、UIWebViewの表示領域を大きくした場合で、表示内容が少ない場合、スクロースなく表示することが出来る。そうなると、「document.documentElement.clientHeight;」は、コンポネントの高さの取得となる。スクロールが発生するような場合は、コンテンツの高さが取得できる。常にコンテンツの高さが取得できるわけではないのだ。

2つ目のやり方だと、コンテンツの内容によらず、コンテンツの高さが取得できる。

## サンプルコード

まずは、HTMLを表示させる。コンテンツのdivのidは、&#8221;contentsDiv&#8221;とした。
  
[c]
  
NSString *html1 = @"<html><head><style type=\"text/css\">body{font-family:Noteworthy-Bold,\"Apple Color Emoji\";}</style></head>"
          
"<body><div id=\"contentsDiv\" style=\"background-color:#dddddd\">☀٩(･×･｡)۶☀<br><a href=\"http://www.google.com/\">Google</a><br>あああ<br>あああ<br>あああ</div></body>"
          
"</html>";
  
[/c] 

以下のDelegateメソッドで、コンテンツの高さを取得する。そして、コンテンツの高さに合わせて、UIWebViewの高さを変更する。
  
[c]
  
-(void)webViewDidFinishLoad:(UIWebView *)webView {
      
NSString *output = [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById(\"contentsDiv\").clientHeight;"];
      
int contentHeight = [output intValue] + 20;

CGRect frame = self.webView.frame;
      
frame.size = CGSizeMake(webView.frame.size.width, contentHeight);
      
self.webView.frame = frame;

NSLog(@"contentHeight is %d", contentHeight);
  
}
  
[/c] 

実行すると、こんな感じになる。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121201a.jpg" alt="" title="20121201a" width="160" height="240" class="alignnone size-full wp-image-2151" />][2]

 [1]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121201b.jpg
 [2]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121201a.jpg
