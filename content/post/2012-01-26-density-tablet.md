---
title: Density(hdpi, mdpi, ldpi)とタブレットを判定する
author: eiKatou
type: post
date: 2012-01-26T14:36:43+00:00
url: /368.html
categories:
  - Android
  - Dev

---
Androidで開発をやっていると、画面の解像度やDensityを判定したくなるときがある。

「[画面の解像度やdensity（ピクセル密度）の取得方法 &#8211; Android Techfirm Lab][1]」を参考にしたのだが、どうも求めている物と違う。
  
xdpi、hdpi, mdpi, ldpiを判定したいのだ。

いろいろと調べた結果、以下のソースコードに落ち着いた。どうも、xdpiは返ってこないよう。。

[java]
  
DisplayMetrics metrics = new DisplayMetrics();
  
activity.getWindowManager().getDefaultDisplay().getMetrics(metrics);
  
if (metrics.densityDpi == DisplayMetrics.DENSITY_XHIGH) {
	  
// xdpi
  
} else if (metrics.densityDpi == DisplayMetrics.DENSITY_HIGH) {
	  
// hdpi
  
} else if (metrics.densityDpi == DisplayMetrics.DENSITY_MEDIUM) {
	  
// mdpi
  
} else if (metrics.densityDpi == DisplayMetrics.DENSITY_LOW) {
	  
// ldpi
  
}
  
[/java]

これは、[前に作ったアプリ][2]で、解像度ごとにアイコンサイズを変更する必要があったので調査した内容。
  
しかし、タブレットだけアイコンサイズが違う。タブレットはmdpiらしいが、アイコンサイズは72&#215;72(hdpi)が使われている。ということで、タブレットの判定も必要になった。

タブレット判定は、以下のコードでできる。Google IOのアプリ内にあるソース。

[java]
  
public static boolean isHoneycomb() {
      
return Build.VERSION.SDK\_INT >= Build.VERSION\_CODES.HONEYCOMB;
  
}

public static boolean isHoneycombTablet(Context context) {
      
return isHoneycomb() && (context.getResources().getConfiguration().screenLayout
              
& Configuration.SCREENLAYOUT\_SIZE\_MASK)
              
== Configuration.SCREENLAYOUT\_SIZE\_XLARGE;
  
}
  
[/java]

参考
  
[Supporting Multiple Screens][3]

 [1]: http://labs.techfirm.co.jp/android/m_yamada/1668
 [2]: https://market.android.com/details?id=net.eikatou.ibf
 [3]: http://developer.android.com/guide/practices/screens_support.html
