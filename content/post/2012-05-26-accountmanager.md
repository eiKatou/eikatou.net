---
title: AccountManagerを使ってGoogleサービスの情報を取得する
author: eiKatou
type: post
date: 2012-05-26T02:10:50+00:00
url: /1506.html
archives:
  - 2012
tags:
  - Android
  - Dev

---
久しぶりにAndroidの開発ネタ。Googleリーダーアプリ（RSSリーダー）を作ろうと思ったことがあり、AccountManagerの使い方を調べていた。

手順としては2段階となる。

  1. Android端末のGoogleアカウントを取得
  2. Googleサービスの情報を取得

AccountManagerを使うと、Android端末に登録されているGoogleのアカウント情報を取得できる。その後、Googleにログイン（認証Tokenを使用）して、Googleサービスの情報を取得する。

## AccountManagerを使用する

AccountManagerで検索すると、以下のサイトが見つかる。丁寧に解説されていて、すごく参考になった。

  * [Account Managerについて &#8211; adsaria mood][1]
  * [AndroidのGoogle Authenticatorを解析(?)してみた | Mine&#8217;s Blog 見習い技術者のメモ帳][2]
  * [Y.A.M の 雑記帳: Android　端末に設定されているアカウント情報を取得][3]

ここはスキップ。上記のサイトを参考に。 

## Googleサービスの情報を取得

これでAccountManagerの使い方は分かるのだが、使い方が分からない。「[Account Managerについて &#8211; adsaria mood][1]」では、最後のサービスのデータ取得までは至っていない。

いろいろ試した結果、HttpHeaderに認証トークンを入れる事で、データ取得ができるようになった。今回は、Googleリーダーの情報が取得するサンプル。

[java]
  
private void loginGoogle(String token) {
    
DefaultHttpClient http_client = new DefaultHttpClient();

HttpGet httpGet = new HttpGet("http://www.google.com/reader/atom/user/-/state/com.google/read");
    
httpGet.setHeader("Authorization", "GoogleLogin auth="+token);
    
HttpResponse response;
    
try {
      
response = http_client.execute(httpGet);
      
InputStream in = response.getEntity().getContent();
      
BufferedReader reader = new BufferedReader(new InputStreamReader(in));
      
String l = null;
      
while ((l = reader.readLine()) != null) {
        
Log.i("MyApp", l);
      
}
    
} catch (Exception e) {
      
e.printStackTrace();
    
}
  
}
  
[/java] 

Googleリーダーの情報が取得できた。
  
[<img src="http://eikatou.net/blog/wp-content/blog/uploads/2012/05/20120526a-300x80.png" alt="" title="20120526a" width="300" height="80" class="alignnone size-medium wp-image-1513" srcset="/blog/uploads/2012/05/20120526a-300x80.png 300w, /blog/uploads/2012/05/20120526a-1024x273.png 1024w, /blog/uploads/2012/05/20120526a-500x133.png 500w, /blog/uploads/2012/05/20120526a.png 1055w" sizes="(max-width: 300px) 100vw, 300px" />][4] 

今回、作ったサンプルのソース。Androidエミュレータで、Googleアカウントを設定してから起動する必要がある。起動後にボタンを押すと、Googleリーダーの情報をLogcatに出力する。
  
[TestAccountManager1.java][5]

* * *

GoogleリーダーのAPIは、以下のサイトを参考にした。正式に公開されていないらしい。

  * [非公式：Google Reader API（グーグルリーダーAPI）（翻訳）][6]
  * [GoogleReaderAPI &#8211; pyrfeed &#8211; This is a RSS/Atom Reader and Framework. It use GoogleReader as a storage database. &#8211; Google Project Hosting][7]

 [1]: http://d.hatena.ne.jp/adsaria/20101012/1286886888
 [2]: http://blog.mine-studio.com/2011/01/android%E3%81%AEgoogle-authenticator%E3%82%92%E8%A7%A3%E6%9E%90%E3%81%97%E3%81%A6%E3%81%BF%E3%81%9F/
 [3]: http://y-anz-m.blogspot.jp/2010/09/android_23.html
 [4]: http://eikatou.net/blog/wp-content/blog/uploads/2012/05/20120526a.png
 [5]: http://eikatou.net/blog/wp-content/blog/uploads/2012/05/TestAccountManager1.java_.zip
 [6]: http://colo-ri.jp/develop/2009/12/google-reader-apiapi.html
 [7]: http://code.google.com/p/pyrfeed/wiki/GoogleReaderAPI
