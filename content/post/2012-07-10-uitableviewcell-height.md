---
title: iOS開発：UITableViewCellの高さを計算する
author: eiKatou
type: post
date: 2012-07-10T14:04:21+00:00
url: /1652.html
archives:
  - 2012
tags:
  - Apple
  - Dev

---
[<img src="/uploads/2012/07/20120710b.png" alt="" title="20120710b" width="184" height="358" class="alignnone size-full wp-image-1655" srcset="/uploads/2012/07/20120710b.png 184w, /blog/uploads/2012/07/20120710b-154x300.png 154w" sizes="(max-width: 184px) 100vw, 184px" />][1]
  
UITableViewCellに大量の文字を表示しようとしている。Twitterクライアントのような感じで。いろいろと試しているうちに、２つのポイントがあることが分かった。

  1. セルの行数指定を無効にする。何行でも表示できるようにする
  2. セルの高さを計算する

参考：[TableViewCellの高さを変更して複数行表示に対応する。｜独学者の独り言][2] 

<!--more-->

## セルの行数指定を無効にする

普通にUITableViewCellを利用すると、最大行数しか文字が表示されない。そのため、最大行数を0行と指定する。Interface Builderで、ラベルのプロパティ「Lines」を&#8221;0&#8243;とする。0行だと文字数分の行数となる。

## セルの高さを計算する

これが少し大変だった。１つ目の行数指定がなくなったので、セルの枠をはみ出て、文字が表示されるようになる。そのため、セルの高さは自前で計算して設定しないと行けない。

まずは、表示するラベルとセル全体の大きさを把握する。

[<img src="/uploads/2012/07/20120710a.png" alt="" title="20120710a" width="646" height="291" class="alignnone size-full wp-image-1653" srcset="/uploads/2012/07/20120710a.png 646w, /blog/uploads/2012/07/20120710a-300x135.png 300w, /blog/uploads/2012/07/20120710a-500x225.png 500w" sizes="(max-width: 646px) 100vw, 646px" />][3]

真ん中のラベルの横幅が255で、高さが52。セル全体の高さは100となっている。 

[c]
  
&#8211; (CGFloat)tableView:(UITableView\*)tableView heightForRowAtIndexPath:(NSIndexPath\*)indexPath {
	  
UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
      
return [TweetCellViewController getCellHeight:tableView cell:cell];
  
}
  
[/c]
  
こちらは、tableviewのdelegateを指定したクラスに追記する。このメソッドで、セルの高さを指定する。

[c]
  
+ (CGFloat)getCellHeight:(UITableView \*)tableView cell:(UITableViewCell \*)cell {
	  
CGSize bounds = CGSizeMake(255, tableView.frame.size.height);
 	  
CGSize size = [cell.textLabel.text sizeWithFont:cell.textLabel.font
                                    
constrainedToSize:bounds
                                        
lineBreakMode:UILineBreakModeCharacterWrap];
      
return size.height + 50.0;
  
}
  
[/c]
  
先ほどのメソッドから、呼び出されるメソッド。ラベルの横幅を指定している。最後に足している50は「セル全体の高さ−ラベルの高さ＋パディング(2)」である。

※ ラベルの横幅の直接指定をなくそうと苦労したが、どこからも取得できなかった。

 [1]: /blog/uploads/2012/07/20120710b.png
 [2]: http://ameblo.jp/dokugakumono/entry-10852241820.html
 [3]: /blog/uploads/2012/07/20120710a.png
