---
title: ListViewのポイント
author: eiKatou
type: post
date: 2010-10-24T08:39:59+00:00
url: /46.html
tags:
  - Android
  - App
  - Dev

---
記念日表示アプリで使用しているListViewのポイントです。

## Adapter

Adapterを使うと、オリジナルの行を表示できるListViewを作成できます。他の方のブログの解説が非常に丁寧で、とても参考になりました。

  * <a href="http://labs.techfirm.co.jp/android/cho/751" target="_blank">ListViewをカスタマイズする | Android Techfirm Lab</a>
  * <a href="http://ichitcltk.hustle.ne.jp/gudon/modules/pico_rd/index.php?content_id=70" target="_blank">ListViewとListActivity（３）-応用編 &#8211; 愚鈍人</a>
  * <a href="http://y-anz-m.blogspot.com/2010/08/android-world-of-listview-headers-and.html" target="_blank">Y.A.M の 雑記帳: Android &#12300;The world of ListView&#12301; &#8211; Headers and footers &#8211;</a>

## 選択できないリスト

普通のListViewはタップすると選択出来ますが、全く選択できないListViewにする事もできます。ArrayAdapterを継承したMyArrayAdapterクラスに、以下の2つのメソッドを@Overrideさせます。
  
[java]
  
@Override
  
public boolean areAllItemsEnabled() {
      
return false;
  
}
  
@Override
  
public boolean isEnabled(int position) {
      
return false;
  
}
  
[/java] 

## 表示位置

ListView#setSelectionFromTop(int position, int y)を使用します。positionで先頭に表示したい行のインデックスを指定します。第2引数のyを指定すると、yの分だけ下にずれて表示されます。
  
[java]
  
ListView listView = (ListView)findViewById(R.id.list);
  
listView.setSelectionFromTop(3, 20);
  
[/java] 

## Fast Scroll

Fast Scrollは、リストビューを上下にスライドさせたときに、右端に出てくる&#8221;つまみ&#8221;でできる高速スクロールの事です。つまみをタップしながら上下にずらすと、高速でスライドさせることができます。

layout.xmlのListViewの属性に、&#8221;andro[id:fastScrollEnabled][1]&#8220;を追加します。
  
[xml]
  
<ListView android:id="@+id/list2"
      
android:layout\_width="fill\_parent"
      
android:layout\_height="wrap\_content"
      
android:fastScrollEnabled="true" />
  
[/xml] 

## 高速化

まだ、やってません。ヒントはこのあたり。

<div class="twitter-detail twitter-detail-left">
  <div class="twitter-detail-user">
    <a class="twitter-user-screen-name" href="http://twitter.com/dumapick"><br /> <img src="http://a0.twimg.com/profile_images/695148648/Owl-48_normal.png" alt="dumapick" height="48" width="48" /><br /> </a>
  </div>
  
  <div class="twitter-detail-tweet">
    <p class="twitter-detail-text">
      ListView表示を早く見せる俺様的コツ(例外あり) 1.convertViewの再利用 2.ViewHolderバターンの適用 3.全データを表示しない 4.表示件数が多い場合は途中でnotifyDataSetChanged 5.データは一括取得しない <a href="http://twitter.com/search?q=%23androiDev" target="_top">#androiDev</a>
    </p>
    
    <p class="twitter-detail-info">
      <a href="http://twitter.com/dumapick/status/27036992502" class="twitter-detail-info-permalink"><span class="twitter-detail-info-date">2010-10-11</span> <span class="twitter-detail-info-time">23:12:26</span></a> <span class="twitter-detail-info-source">via <a href="http://seesmic.com/seesmic_mobile/android/" rel="nofollow">Seesmic for Android</a></span>
    </p>
  </div>
</div>

<div class="twitter-detail twitter-detail-left">
  <div class="twitter-detail-user">
    <a class="twitter-user-screen-name" href="http://twitter.com/dumapick"><br /> <img src="http://a0.twimg.com/profile_images/695148648/Owl-48_normal.png" alt="dumapick" height="48" width="48" /><br /> </a>
  </div>
  
  <div class="twitter-detail-tweet">
    <p class="twitter-detail-text">
      ListViewのAdapterにセットするデータはAsyncTaskかHandlerを使ったUIスレッドで取得すると吉。また一括取得するAPI(PackageManager系のAPIとか)をベースに何かしたいときは、取得後1回のループで済むように設計する <a href="http://twitter.com/search?q=%23androiDev" target="_top">#androiDev</a>
    </p>
    
    <p class="twitter-detail-info">
      <a href="http://twitter.com/dumapick/status/27037819155" class="twitter-detail-info-permalink"><span class="twitter-detail-info-date">2010-10-11</span> <span class="twitter-detail-info-time">23:21:26</span></a> <span class="twitter-detail-info-source">via <a href="http://seesmic.com/seesmic_mobile/android/" rel="nofollow">Seesmic for Android</a></span>
    </p>
  </div>
</div>

  * <a href="http://labs.techfirm.co.jp/android/cho/2161" target="_blank">Adapterの高速化 | Android Techfirm Lab</a>
  * <a href="http://y-anz-m.blogspot.com/2010/08/androidthe-world-of-listview.html" target="_blank">Y.A.M の 雑記帳: Android&#12288;&#12300;The world of ListView&#12301;&#12288;- Virtualization and adapters &#8211;</a>

 [1]: http://d.hatena.ne.jp/fastScrollEnabled/
