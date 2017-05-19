---
title: iOS開発：アプリケーション再申請
author: eiKatou
type: post
date: 2012-12-07T13:50:23+00:00
url: /2189.html
tags:
  - Apple
  - Dev

---
[<img src="http://eikatou.net/blog/wp-content/uploads/2012/12/201207a.png" alt="" title="201207a" width="455" height="215" class="alignnone size-full wp-image-2191" srcset="/uploads/2012/12/201207a.png 455w, /uploads/2012/12/201207a-300x141.png 300w" sizes="(max-width: 455px) 100vw, 455px" />][1]
  
以前に申請していたアプリだが、見事にリジェクトされてしまった。予想通りだけど、少し凹む・・。

リジェクトの理由は、[iOS Data Storage Guidelines][2]に従っていないためだった。
  
これの内容を見ていくと、「iCloudバックアップされるディレクトリには、ユーザが作成したデータを置く。再ダウンロード可能なデータなどは、別のディレクトリに置きなさい」とのこと。つまり、「何でも、iCloudバックアップさせないように！」という意味。

以下のサイトが参考になった。

  * [App Storeの審査経過報告[iCloud対応] &#8211; スマホ事業室Web出張所～エンジニアのアウトプット～][3]
  * [Data Storage Guidelineに従ったオフラインデータの保存と確認方法 &#8211; kakin.infoサポート][4]
  * [アプリケーションディレクトリの構造とアクセス方法 &#8211; プログラミングノート][5]
  * [Cocoaの日々: [Info] 特定のファイルをiCloudバックアップ対象外にする][6]

## 対応する

対応は簡単だった。今まで「[Application_Home]/Documents」に全データを置いていたのだが、データの配置場所を変更することにした。

画像イメージは「[Application\_Home]/Library/Caches」に、データベースファイルは「[Application\_Home]/Library/Private Documents」に置くことにした。

Caches以下は、ディスク容量が足りなくなると消される可能性があるので、データベースファイルは置けない。そこで別ディレクトリを作成する。注意するのは、このディレクトはiCloudバックアップされてしまうのだ。そこで、no backup属性を付与して、iCloudバックアップさせないように設定する。

no backup属性を付与するためのコードは、[Technical Q&A QA1719: Technical Q&A QA1719][7]を参考にした。これを呼び出せば、バックアップされなくなる。

少し悩んだ箇所は、NSString型のファイルパスをNSURLに変換するやりかた。以下のようにすれば問題なく動いた。
  
[c]
  
// fileURLWithPathを使う
  
[DatabaseHelper addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:dbPath];
  
[/c] 

iPhoneシミュレータで起動した後、属性がついていることを確認する。
  
[bash]
  
$ cd /Users/ei/Library/Application Support/iPhone Simulator/6.0/Applications/AA98DACC-4167-4A98-A6C5-EFC709CA80D2
  
$ xattr Library/Private\ Documents/app.db
  
com.apple.metadata:com\_apple\_backup_excludeItem
  
[/bash]
  
xattrコマンドでファイルの属性を見ると、バックアップ対象外となっている。 

## 再申請

[<img src="http://eikatou.net/blog/wp-content/uploads/2012/11/121125-0011.png" alt="" title="121125-0011" width="466" height="235" class="alignnone size-full wp-image-2110" srcset="/uploads/2012/11/121125-0011.png 466w, /uploads/2012/11/121125-0011-300x151.png 300w" sizes="(max-width: 466px) 100vw, 466px" />][8]
  
再度、バイナリをアップロードして、「Waiting For Review」ステータスになった。また、リジェクトになる気がするなぁ・・。

 [1]: http://eikatou.net/blog/wp-content/uploads/2012/12/201207a.png
 [2]: https://developer.apple.com/icloud/documentation/data-storage/
 [3]: http://d.hatena.ne.jp/sppsolcojp/20120323/1332493306
 [4]: http://support.kakin.info/ios-technical-info/data-storage-guidelineni-congttaofuraindetano-deng-luto-que-ren-fang-fa
 [5]: http://d.hatena.ne.jp/ntaku/20110104/1294146555
 [6]: http://cocoadays.blogspot.jp/2011/11/info-icloud.html
 [7]: https://developer.apple.com/library/ios/#qa/qa1719/_index.html
 [8]: http://eikatou.net/blog/wp-content/uploads/2012/11/121125-0011.png
