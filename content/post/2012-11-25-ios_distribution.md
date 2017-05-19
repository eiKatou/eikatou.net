---
title: iOS開発：アプリケーション申請
author: eiKatou
type: post
date: 2012-11-25T14:31:22+00:00
url: /2109.html
archives:
  - 2012
tags:
  - Apple
  - Dev

---
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/11/121125-0011.png" alt="" title="121125-0011" width="466" height="235" class="alignnone size-full wp-image-2110" srcset="/uploads/2012/11/121125-0011.png 466w, /uploads/2012/11/121125-0011-300x151.png 300w" sizes="(max-width: 466px) 100vw, 466px" />][1]
  
開発中のアプリ（MyTweet+）を申請した。申請手順が多くて、丸一日ぐらいかかってしまった。「Waiting For Review」ステータスなので、レビュー待ち状態。

以下のページの通りで申請できた。非常に助かった。

  * [iPhoneアプリの公開手順、ビルドから登録まで &#8211; えんたつの記録][2]
  * [iPhoneアプリ、公開用ビルド作成までの手順 &#8211; えんたつの記録][3]
  * [Xcode4でiPhoneアプリをiTunes Connectに登録する方法 &#8211; えんたつの記録][4]
  * [HTTPS を使ってるアプリを AppStore や Android Market で配信するときの輸出手続きについて（その2) &#8211; 規制対象になるかどうかの判断 &#8211; むらかみの雑記帳][5]

## 申請時に困った箇所＆失敗した箇所

１つ目。App IDの「Bundle Identifier」項目。アプリケーション固有の識別文字列を入れる。”net.eikatou”と入れてしまい、後から残念感でいっぱいに。アプリケーション固有のIDなので、”net.eikatou.mytweetplus”とした方が良かった。
  
仕方ないので、そのままで進んだ。

２つ目。アプリケーション名に”+”を入れると、XcodeからiTunesへ送信する前の検証でエラーになった。
  
[iphone &#8211; My iOS app has a + in its name. Bundle is invalid due to this. Need help resolving &#8211; Stack Overflow][6]
  
実際に「Camera+」とかあるから、アプリケーション名に”+”は入れられるはず。何が問題だったかと言うと、アプリのバイナリの名前に”+”がついていたことだった。なので、MyTweet+からMyTweetPlusに、プロジェクト名を変更。その後、Info.plistの「Bundle display name」を”MyTweet+”にすれば検証を通った。

 [1]: http://eikatou.net/blog/wp-content/uploads/2012/11/121125-0011.png
 [2]: http://blog.livedoor.jp/tattyamm/archives/1177705.html
 [3]: http://blog.livedoor.jp/tattyamm/archives/1177013.html
 [4]: http://blog.livedoor.jp/tattyamm/archives/2957285.html
 [5]: http://tmurakam.hatenablog.com/entry/20111010/1318173222
 [6]: http://stackoverflow.com/questions/8275642/my-ios-app-has-a-in-its-name-bundle-is-invalid-due-to-this-need-help-resolvi
