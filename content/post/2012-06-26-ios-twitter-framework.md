---
title: iOS開発：iOS Twitter frameworkを使う
author: eiKatou
type: post
date: 2012-06-25T22:10:50+00:00
url: /1581.html
categories:
  - Apple
  - Dev

---
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/06/20120626a.png" alt="" title="20120626a" width="509" height="352" class="alignnone size-full wp-image-1584" srcset="/uploads/2012/06/20120626a.png 509w, /uploads/2012/06/20120626a-300x207.png 300w, /uploads/2012/06/20120626a-433x300.png 433w" sizes="(max-width: 509px) 100vw, 509px" />][1]
  
iOS Twitter frameworkを使って、Twitterの情報を取得する。

かなり簡単だった。まずは以下のサイトを読む。

  * [iOS Twitter framework | Twitter Developers][2]
  * [API requests with TWRequest | Twitter Developers][3]
  * [iOS 5でTwitterを使う方法（カスタムな方） &#8211; Debian GNU/Linux 3.1 on PowerMac G4][4]
  * [ACAccountとACAccountStoreの関係 &#8211; 作戦：いろいろやろうぜ][5]

<!--more-->

## iOSに設定されているアカウント情報を取得する。

&#8220;Linked Frameworks and Libraries&#8221;に、&#8221;Accounts.framework&#8221;を追加する。
  
[c]
  
self.accountStore = [[ACAccountStore alloc] init];
  
ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];

[accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
      
if(granted) {
          
// Get the list of Twitter accounts.
          
NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];

if ([accountsArray count] > 0) {
              
self.twAccount = [accountsArray objectAtIndex:0];
              
accountLable.text = twAccount.username;
          
} else {
              
accountLable.text = [NSString stringWithString:@"Sorry."];
          
}
      
}
  
}];
  
[/c] 

OSにTwitterアカウントが登録されていないと、アカウントが取得できない。

## Twitterの情報を取得する

&#8220;Linked Frameworks and Libraries&#8221;に、&#8221;Twitter.framework&#8221;を追加する。ここでは、お気に入りの情報を取得するようにした。
  
[c]
  
NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1/favorites.json"];

NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  
[params setObject:@"eiKatou" forKey:@"screen_name"];
  
[params setObject:@"5" forKey:@"count"];

TWRequest *getFavReq = [[TWRequest alloc] initWithURL:url
                                             
parameters:params
                                          
requestMethod:TWRequestMethodGET];
  
[getFavReq setAccount:twAccount];

[getFavReq performRequestWithHandler:
   
^(NSData \*responseData, NSHTTPURLResponse \*urlResponse, NSError *error) {
       
NSLog(@"HTTP response status: %i", urlResponse.statusCode);

if (responseData) {
           
NSError *jsonError;
           
NSArray *timeline = [NSJSONSerialization JSONObjectWithData:responseData
                                                               
options:NSJSONReadingMutableLeaves
                                                                 
error:&jsonError];
           
if (timeline) {
  
// NSLog(@"%@", timeline);
               
for (NSDictionary *tweet in timeline) {
                   
NSLog(@"tweet :%@", tweet);
                   
NSLog(@"tweet text :%@", [tweet objectForKey:@"text"]);
                   
NSLog(@"tweet created\_at :%@", [tweet objectForKey:@"created\_at"]);

}

} else {
               
NSLog(@"%@", jsonError);
           
}
       
}
  
}]
  
[/c] 

Twitterの情報を取得するには、URLを作って、JSON形式の戻り値をパースすれば良い。NSJSONSerializationは、NSArrayとNSDictionaryでオブジェクトが返ってくる。汎用的で、使いやすいように思った。欲を言えば、GSON的なのが欲しい。

&#8220;TWRequest performRequestWithHandler:&#8221;で、EXC\_BAD\_ACCESSが出て困ってしまった。[cocoa touch &#8211; Using blocks within blocks in Objective-C: EXC\_BAD\_ACCESS &#8211; Stack Overflow][6]にあるように、ACAccountStoreの参照がなくなったことで、ACAccountも回収されてしまったことでエラーとなっていた。ACAccountStoreの参照を保持するようにしたら、エラーも出なくなった。

## サンプル

他サイトのサンプルソースをコピペして作った物。GetAccountボタンを押すと、アカウントを取得する。GetFavoriteボタンを押すと、お気に入りを取得してログに出力する。
  
[iOSTwitterSample1][7]

余談だが、Twitterクライアントを作っている人が言うには、このiOS Twitter frameworkは地雷らしい。できないことが多々あるらしいので、本格的なTwitterクライアントでの使用には向かないとの事。

 [1]: http://eikatou.net/blog/wp-content/uploads/2012/06/20120626a.png
 [2]: https://dev.twitter.com/docs/ios
 [3]: https://dev.twitter.com/docs/ios/making-api-requests-twrequest
 [4]: http://d.hatena.ne.jp/paraches/20111205
 [5]: http://d.hatena.ne.jp/kykomi/20120418/1334751506
 [6]: http://stackoverflow.com/questions/8662156/using-blocks-within-blocks-in-objective-c-exc-bad-access
 [7]: http://eikatou.net/blog/wp-content/uploads/2012/06/iOSTwitterSample1.zip
