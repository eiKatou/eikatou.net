---
title: Gsonの使い方（JSONをJava Objectsに変換）
author: eiKatou
type: post
date: 2012-02-18T11:38:03+00:00
url: /633.html
archives:
  - 2012
tags:
  - Dev
  - Java

---

![gson_logo](/uploads/2012/02/201202_gson_logo.jpg)

前のAndroidアプリの開発で、JSONデータをJava Objectsに変換したかった。この時にGsonを知った。JSONデータのデシリアライズの方法を紹介する。

# Gsonとは

GsonはJavaのライブラリで、JSONデータをJava Objectsに変換したり、Java ObjectsをJSONデータに変換したりすることが出来る。
  
以下は本家の開発サイト。オープンソースプロジェクト！

  * [google-gson][1]
  * [Gson User Guide][2]

サンプルを淡々とのせると面白くないので、TwitterのAPIを呼び出すサンプルにした。Gsonのバージョンは2.0を使っている。
  
サンプルソースのダウンロードは[こちら][3]。お好きにどうぞ。 

<!--more-->

# サンプル１：Twitterのユーザ情報を取得する

## ユーザ情報JSON

まずは、JSONデータを呼び出せることを確認。
  
eiKatouは私のアカウント。自分のアカウント名でお試しあれ。
  
<https://twitter.com/users/show/eiKatou.json>

```javascript
{
  id: 115794727,
  screen_name: "eiKatou",
  location: "兵庫県",
  name: "かとう えい",
  その他・・
}
```
  
上記の内容が入っている。このデータをJavaのオブジェクトへ変換する。

## Javaへ変換して表示

```java
public class User {
  String id;
  String screen_name;
  String name;
  @SerializedName("location")
  String basho;
}
```
  
上記はJSONデータを格納するUserクラス。

```java
// JSON to Java
Gson gson = new Gson();
User user = gson.fromJson(jsonData.toString(), User.class);
System.out.println("id = " + user.getId());
System.out.println("screen name = " + user.getScreen_name());
System.out.println("name = " + user.getName());
System.out.println("basho = " + user.getBasho());
```
  
Userクラスを指定して、JSONをデシリアライズする。これを実行すると、対象のデータを表示する。 

## ポイント

  * JSONに対応するクラスを用意する
  * Javaクラスのフィールド名は、JSONのフィールド名と同じにする
  * JSONのフィールド名と別名にしたいときは、アノテーションを指定

# サンプル2：Twitterのユーザタイムラインを取得する

## ユーザタイムラインJSON

JSONデータを呼び出せることを確認。
  
私のTwitterID「115794727」を指定している。サンプル1を動かすと、TwitterIDが手に入る。
  
<http://api.twitter.com/1/statuses/user_timeline/115794727.json>

```javascript
[{
    id_str: "170792755415625728",
    created_at: "Sat Feb 18 08:52:20 +0000 2012",
    user: {
      id: 115794727,
      location: "兵庫県",
      name: "かとう えい",
      その他省略・・
    },
    id: 170792755415625730,
    text: "今日はブログを書く。",
    その他省略・・
  }, {
    id_str: "170760803748818944",
    created_at: "Sat Feb 18 06:45:22 +0000 2012",
    user: {
      id: 115794727,
      location: "兵庫県",
      name: "かとう えい",
      その他省略・・
    },
    id: 170760803748818940,
    text: "WIRED.jp http://t.co/5X0hk4po",
    その他省略・・
  },
  その他のTweet省略・・
]

```
  
上記の内容が入っている（かなり省略した）。先ほどと違うのは、配列で返ってきていること。配列の中身はTweetの情報。
  
このデータをJavaのオブジェクトへ変換する。

## Javaへ変換して表示

```java
public class Tweet {
  private String id_str;
  private String id;
  private String text;
  private User user;
  // getter, setterは記述を省略・・
}
```
  
上記がTweetを格納するクラス。

```java
// JSON to Java
Gson gson = new Gson();
Type collectionType = new TypeToken<Collection<Tweet>>(){}.getType();
List<Tweet> timeLine = gson.fromJson(jsonData.toString(), collectionType);
for (Tweet tweet : timeLine) {
  System.out.println("tweet user = " + tweet.getUser().name);
  System.out.println("id\_str = " + tweet.getId\_str());
  System.out.println("id = " + tweet.getId());
  System.out.println("text = " + tweet.getText());
  System.out.println();
}
```
  
コレクション型を指定して、JSONをデシリアライズする。実行すると、対象のTweetデータを表示する。20件ほど表示される。

## ポイント

  * 配列が返ってくるときは、Type（コレクション）を指定する

# サンプル3：Twitterのキーワード検索の結果

## 検索結果JSON

JSONデータを呼び出せることを確認。「eiKatou」で検索した場合のJSON。
  
<http://search.twitter.com/search.json?q=eiKatou>

```javascript
{
  page: 1,
  query: "eiKatou",
  refresh\ _url: "?since\_id=170794708556197888&q=eiKatou",
  results: [{
      created_at: "Sat, 18 Feb 2012 09:00:06 +0000",
      from_user: "eiKatou",
      from\ _user\ _id: 115794727,
      from\ _user\ _id_str: "115794727",
      from\ _user\ _name: "かとう えい",
      id: 170794708556197900,
      id_str: "170794708556197888",
      text: "今日はいい天気。",
      省略・・
    }, {
      created_at: "Sat, 18 Feb 2012 09:00:06 +0000",
      from_user: "eiKatou",
      from\ _user\ _id: 115794727,
      from\ _user\ _id_str: "115794727",
      from\ _user\ _name: "かとう えい",
      id: 170794708556197900,
      id_str: "170794708556197888",
      text: "フォローミー！",
      省略・・
    },
    省略・・
  ],
  省略・・
}
```
  
上記の内容が入っている。先ほどと違うのは、オブジェクトの中に配列があること。
  
このデータをJavaのオブジェクトへ変換する。

## Javaへ変換して表示

```java
public class SearchResults {
  private int page;
  private String query;
  private List<Tweet> results;
  // getter, setterは記述を省略・・
    
}
```
  
上記はJSONデータを格納するSearchResultsクラス。
  
resultsはJSONのフィールド名と同じにしている。検索結果のTweetがresultsに入ってくる。

```java
// JSON to Java
Gson gson = new Gson();
SearchResults results = gson.fromJson(jsonData.toString(),
SearchResults.class);
System.out.println("page = " + results.getPage());
System.out.println("query = " + results.getQuery());
System.out.println();
for (Tweet tweet : results.getResults()) {
  // tweet.getUser() is null.
  // System.out.println("tweet user = " + tweet.getUser().getName());
  System.out.println("id\_str = " + tweet.getId\_str());
  System.out.println("id = " + tweet.getId());
  System.out.println("text = " + tweet.getText());
  System.out.println();
}
  
```
  
これを実行すると、検索結果のtweet一覧が表示される。中に配列が入っていても簡単！ 

## ポイント

  * オブジェクトの中の配列は、List型に入れてくれる

# まとめ

Gsonを使うと簡単にデシリアライズできる。
  
他のJSON関係のライブラリに比べると、デシリアライズが早いらしい。なので、JSON関係のライブラリの本命だと思っている。開発が活発で、今後の機能追加も楽しみだ。

（追伸1）
  
Gson以外だと、[JsonPullParser][4]も気になっている。

（追伸2）
  
Gsonは、Androidでも使うことが出来る。AndroidでTwitterアプリを作りたい方、私好みのTwitterアプリを作ってください！


 [1]: http://code.google.com/p/google-gson/
 [2]: http://sites.google.com/site/gson/gson-user-guide
 [3]: /uploads/2012/02/gson_sample1.zip
 [4]: https://github.com/vvakame/JsonPullParser/wiki/JsonPullParser_ja
