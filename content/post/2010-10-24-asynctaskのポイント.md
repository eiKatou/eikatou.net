---
title: AsyncTaskのポイント
author: eiKatou
type: post
date: 2010-10-24T09:06:30+00:00
url: /47.html
archives:
  - 2010
tags:
  - Android
  - App
  - Dev

---
<div class="section">
  <h4>
    AsyncTaskを使う
  </h4>
  
  <p>
    アプリで処理に時間がかかる場合、Progress Dialogを表示しつつ、別スレッドで処理を行う。よくあるパターンです。今回作成した&#8221;Anniversary&#8221;もDBに200件ほど書き込む処理があるので、このパターンを使っています。Thread + Handlerの方法はよく紹介されていますが、AsyncTaskを使った方が簡単に実現できます。
  </p>
  
  <p>
    これまた、素晴らしい解説ページがあったので、リンク先のページを参照してください。1番目のリンクは、&#8221;処理中に画面が回転するとエラーが発生する&#8221;問題に対応した方法がのっています。とても参考になりました。
  </p>
  
  <ul>
    <li>
      <a href="http://www.bpsinc.jp/blog/archives/1858" target="_blank">Android: ダイアログを表示して縦横が変わるとdismissでエラー &#171; BPS株式会社 開発ブログ Beyond Perspective Solutions LTD.</a>
    </li>
    <li>
      <a href="http://labs.techfirm.co.jp/android/cho/1079" target="_blank">AsyncTaskでユーザビリティを向上させる | Android Techfirm Lab</a>
    </li>
    <li>
      <a href="http://www.adamrocker.com/blog/255/hello-android-chapter7-the-connected-world.html" target="_blank">throw Life &#8211; 初めてのAndroid -第7章 世界との接続-</a>
    </li>
    <li>
      <a href="http://y-anz-m.blogspot.com/2010/10/androidzippy-apps-tips.html" target="_blank">Y.A.M の 雑記帳: Android&#12288;Zippy apps tips</a>
    </li>
  </ul>
</div>
