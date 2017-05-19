---
title: Googleの２段階認証を設定（アカウントの乗っ取りに対処）
author: eiKatou
type: post
date: 2012-12-22T12:38:12+00:00
url: /2267.html
tags:
  - 雑記

---
昨日、Googleのメインアカウントが不正ログイン（乗っ取り）され、多数のスパムメールを発信することになってしまった。

異変に気がついたのは、会社での仕事中。自分のGmailからメールが届いて、本文はリンクのみ。明らかにおかしい・・。しかも、メールの宛先には、知っている人の名前がずらりと３０名ほど。

メールの宛先を見たところ、「メールもアドレスも根こそぎ、コピーされたんだろうな。解析して、スパムメールを出しているな」と感じた。本当にすみません。

次の被害に遭わないために、設定した内容を残しておく。

<!--more-->

## 不正ログインだと分かった経緯

Googleのアカウントにログインしようとすると、警告が表示された。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121222a.jpg" alt="" title="20121222a" width="320" height="480" class="alignnone size-full wp-image-2269" srcset="/uploads/2012/12/20121222a.jpg 320w, /uploads/2012/12/20121222a-200x300.jpg 200w" sizes="(max-width: 320px) 100vw, 320px" />][1]
  
「不正な操作が検出されました。」と教えてもらったので、不正ログインだと判明。当初は、スマートフォンのアドレス帳の情報を抜かれた可能性を疑っていた。 

SMSで確認を行って、パソコンでGmailにログイン。スクロールすると右下に「アカウント アクティビティの詳細」と出てくるので、ログイン履歴を確認した。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121222c-300x187.jpeg" alt="" title="20121222c" width="300" height="187" class="alignnone size-medium wp-image-2270" srcset="/uploads/2012/12/20121222c-300x187.jpeg 300w, /uploads/2012/12/20121222c.jpeg 460w" sizes="(max-width: 300px) 100vw, 300px" />][2]
  
アメリカからのアクセスされている。メールの送信日時と同じ時刻なので、これに間違いない。ここで、「他のセッションをすべてログアウト」を押して、他のログインセッションを無効にした。 

参考：[yoko_net　Blog : gmailが不正アクセスされスパムメールが送信された件について][3]

## ２段階認証プロセスを設定

すぐにパスワードを変更。この時、２段階認証プロセスを初めて設定した。

２段階認証は、通常のIDとパスワードの認証と、SMSによる認証を組み合わせる方式。IDとパスワードの認証が成功したら、SMSが送られてくる。そのSMSの番号を入力しないとログインできない仕組み。
  
つまり、パスワードが分かっても、その人の携帯電話がないとログインできない。

２段階認証は、以下の手順で設定できる。

  1. Googleのトップページを開く
  2. 右上のアイコンをクリックして、アカウントのページを開く
  3. セキュリティのページを開く
  4. 「2 段階認証プロセス」のステータスをONにする

こんな簡単な作業で、セキュリティが向上する。どうしてやってなかったのか、と本当に後悔した。 

他のパソコンで、IDとパスワードを入れてログインしようとすると、こんな画面が表示される。
  
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/20121222b-300x300.jpg" alt="" title="20121222b" width="300" height="300" class="alignnone size-medium wp-image-2268" srcset="/uploads/2012/12/20121222b-300x300.jpg 300w, /uploads/2012/12/20121222b-150x150.jpg 150w, /uploads/2012/12/20121222b-299x300.jpg 299w, /uploads/2012/12/20121222b-120x120.jpg 120w, /uploads/2012/12/20121222b.jpg 305w" sizes="(max-width: 300px) 100vw, 300px" />][4]
  
このように、他のパソコンからログインできなくなる。
  
認証コードを入れられる本人だと、ログインが可能。

## スマートフォンアプリとの連携

２段階認証を設定すると、スマートフォンアプリと連携できない場合がある。アプリが２段階認証に対応していない場合だ。iPhoneのメールアプリの設定なども、２段階認証に対応していない。この時は、Googleのセキュリティページで、設定を行う必要がある。
  
[google二段階認証有効時のExchangeパスワード設定 | iPhone | たぬの麻雀日記][5] 

## あまかった

メインのGoogleアカウントにログインされるなんて、本当にショックだった。まさか自分が・・といった感じだ。パスワードも８文字に設定したし、他のサイトで使い回しもしていなかった。８文字程度だと総当たりで、すぐに判明してしまうようだ。

パスワードは２５文字以上 ＆ ２段階認証プロセスの設定 をしておかないといけない。

スパムメールが届いた皆様、本当に申し訳ございませんでした。

 [1]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121222a.jpg
 [2]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121222c.jpeg
 [3]: http://blog.livedoor.jp/yoko_net/archives/51986312.html
 [4]: http://eikatou.net/blog/wp-content/uploads/2012/12/20121222b.jpg
 [5]: http://www.meet2partner.com/b/entries/google-2phase-auth-config-exchange-password-for-iphone.html