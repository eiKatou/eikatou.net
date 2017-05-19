---
title: iOS開発：OHAttributedLabelの行間を調整する
author: eiKatou
type: post
date: 2012-09-01T23:54:36+00:00
url: /2019.html
categories:
  - Apple
  - Dev

---
[iOS開発：UILabelでリッチにテキスト表示（OHAttributedLabel）][1]で、UILabelの表示をカスタマイズしたが、気になる点が残っている。それは、行間の広さだ。

[<img src="http://eikatou.net/blog/wp-content/uploads/2012/08/CoreTextLabelSample01.png" alt="" title="CoreTextLabelSample01" width="320" height="480" class="alignnone size-full wp-image-2000" srcset="/uploads/2012/08/CoreTextLabelSample01.png 320w, /uploads/2012/08/CoreTextLabelSample01-200x300.png 200w" sizes="(max-width: 320px) 100vw, 320px" />][2]
  
前回の結果だが、OHAttributedLabel（上）を使うと、通常のUILabel（下）よりも、行間が広くなっている。しかも、OHAttributedLabel（上）の1行目と2行目の間だけ、さらに広くなってしまっている。

<!--more-->

## 原因

全体的に行間が広くなっているのは、OHAttributedLabelの問題だろう。

1行目と2行目の間が広くなっているのは、CoreTextのフォントのレンダリングの問題。日本語フォントと英字フォントの高さの違いからくるようだ。解決策も既出で助かった。

  * [Tweetbot：日本語テキストの行間について | E-WA’s Blog][3]
  * [CoreTextの日本語行間の問題(解決) &#8211; novi&#8217;s page][4]

## 修正する

解決策があるようなので、OHAttributedLabelに組み込んでみた。NSAttributedString+Attributes.mを修正する。

[c]
  
-(void)setTextAlignment:(CTTextAlignment)alignment lineBreakMode:(CTLineBreakMode)lineBreakMode {
	  
[self setTextAlignment:alignment
               
lineBreakMode:lineBreakMode
               
maxLineHeight:14.0f
               
minLineHeight:14.0f
              
maxLineSpacing:4.0f
              
minLineSpacing:4.0f
                       
range:NSMakeRange(0,[self length])];
  
}

-(void)setTextAlignment:(CTTextAlignment)alignment
            
lineBreakMode:(CTLineBreakMode)lineBreakMode
            
maxLineHeight:(CGFloat)maxLineHeight
            
minLineHeight:(CGFloat)minLineHeight
           
maxLineSpacing:(CGFloat)maxLineSpacing
           
minLineSpacing:(CGFloat)minLineSpacing
                    
range:(NSRange)range {

CTParagraphStyleSetting paraStyles[6];

paraStyles[0].spec = kCTParagraphStyleSpecifierMaximumLineHeight;
	  
paraStyles[0].valueSize = sizeof(CGFloat);
	  
paraStyles[0].value = &maxLineHeight;

paraStyles[1].spec = kCTParagraphStyleSpecifierMinimumLineHeight;
	  
paraStyles[1].valueSize = sizeof(CGFloat);
	  
paraStyles[1].value = &minLineHeight;

paraStyles[2].spec = kCTParagraphStyleSpecifierMaximumLineSpacing;
	  
paraStyles[2].valueSize = sizeof(CGFloat);
	  
paraStyles[2].value = &maxLineSpacing;

paraStyles[3].spec = kCTParagraphStyleSpecifierMinimumLineSpacing;
	  
paraStyles[3].valueSize = sizeof(CGFloat);
	  
paraStyles[3].value = &minLineSpacing;

paraStyles[4].spec = kCTParagraphStyleSpecifierAlignment;
	  
paraStyles[4].valueSize = sizeof(CTTextAlignment);
	  
paraStyles[4].value = (const void*)&alignment;

paraStyles[5].spec = kCTParagraphStyleSpecifierLineBreakMode;
	  
paraStyles[5].valueSize = sizeof(CTLineBreakMode);
	  
paraStyles[5].value = (const void*)&lineBreakMode;

CTParagraphStyleRef aStyle = CTParagraphStyleCreate(paraStyles, 6);
	  
[self removeAttribute:(NSString*)kCTParagraphStyleAttributeName range:range]; // Work around for Apple leak
	  
[self addAttribute:(NSString*)kCTParagraphStyleAttributeName value:(id)aStyle range:range];
	  
CFRelease(aStyle);
  
}
  
[/c]

これで、以下のように高さが揃うようになる。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/09/20120902b.png" alt="" title="20120902b" width="320" height="480" class="alignnone size-full wp-image-2034" srcset="/uploads/2012/09/20120902b.png 320w, /uploads/2012/09/20120902b-200x300.png 200w" sizes="(max-width: 320px) 100vw, 320px" />][5]

[サンプルダウンロード：CoreTextLabelSample01][6] 

* * *

[iOS開発：OHAttributedLabelの行間を調整する][7]につづく

 [1]: http://eikatou.net/blog/2012/08/ios_rich_uilabel_1/
 [2]: http://eikatou.net/blog/wp-content/uploads/2012/08/CoreTextLabelSample01.png
 [3]: http://ewa4618.vjck.com/2011/07/05/tweetbot%EF%BC%9A%E6%97%A5%E6%9C%AC%E8%AA%9E%E3%83%86%E3%82%AD%E3%82%B9%E3%83%88%E3%81%AE%E8%A1%8C%E9%96%93%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6/
 [4]: http://novis.jimdo.com/2011/07/02/coretext%E3%81%AE%E6%97%A5%E6%9C%AC%E8%AA%9E%E8%A1%8C%E9%96%93%E3%81%AE%E5%95%8F%E9%A1%8C-%E8%A7%A3%E6%B1%BA/
 [5]: http://eikatou.net/blog/wp-content/uploads/2012/09/20120902b.png
 [6]: http://eikatou.net/blog/wp-content/uploads/2012/09/CoreTextLabelSample01.zip
 [7]: http://eikatou.net/blog/2012/09/ios_rich_uilabel_2/
