---
title: AdMobの広告をPreferenceScreenで表示する
author: eiKatou
type: post
date: 2010-11-21T09:18:26+00:00
url: /50.html
categories:
  - Android
  - Dev

---
<div class="section">
  <p>
    PreferenceActivityを使った設定画面に、AdMobの広告を追加します。表示の方法は2パターンです。
  </p>
  
  <h4>
    パターン1(設定項目の最後尾に追加)
  </h4>
  
  <p>
    <a class="hatena-fotolife" href="http://f.hatena.ne.jp/Sirokoix/20101121181734" target="_blank"><img class="hatena-fotolife" title="f:id:Sirokoix:20101121181734p:image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/S/Sirokoix/20101121/20101121181734.png" alt="f:id:Sirokoix:20101121181734p:image" /></a>
  </p>
  
  <p>
    一番下までスクロールすると設定項目の一つとして、広告が見えてくるようになります。まず、広告の入った設定項目を作ります。それをpreference.xmlで読み込みます。
  </p>
  
  <p>
    admob_preference.xml
  </p>
  
  <pre class="syntax-highlight"><span class="synComment">&lt;?</span><span class="synType">xml version</span>=<span class="synConstant">"1.0"</span><span class="synType"> encoding</span>=<span class="synConstant">"utf-8"</span><span class="synComment">?&gt;</span>
<span class="synIdentifier">&lt;LinearLayout </span>
<span class="synType">xmlns</span><span class="synComment">:</span><span class="synType">android</span>=<span class="synConstant">"http://schemas.android.com/apk/res/android"</span>
<span class="synType">xmlns</span><span class="synComment">:</span><span class="synType">myapp</span>=<span class="synConstant">"http://schemas.android.com/apk/res/sample"</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">orientation</span>=<span class="synConstant">"vertical"</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">layout_width</span>=<span class="synConstant">"fill_parent"</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">layout_height</span>=<span class="synConstant">"50px"</span><span class="synIdentifier">&gt;</span>
<span class="synIdentifier">&lt;com</span><span class="synComment">.</span><span class="synIdentifier">admob</span><span class="synComment">.</span><span class="synIdentifier">android</span><span class="synComment">.</span><span class="synIdentifier">ads</span><span class="synComment">.</span><span class="synIdentifier">AdView</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">id</span>=<span class="synConstant">"@+id/ad"</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">layout_width</span>=<span class="synConstant">"fill_parent"</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">layout_height</span>=<span class="synConstant">"wrap_content"</span>
<span class="synType">myapp</span><span class="synComment">:</span><span class="synType">backgroundColor</span>=<span class="synConstant">"#000000"</span>
<span class="synType">myapp</span><span class="synComment">:</span><span class="synType">primaryTextColor</span>=<span class="synConstant">"#FFFFFF"</span>
<span class="synType">myapp</span><span class="synComment">:</span><span class="synType">secondaryTextColor</span>=<span class="synConstant">"#CCCCCC"</span><span class="synIdentifier"> /&gt;</span>
<span class="synIdentifier">&lt;/LinearLayout&gt;</span></pre>
  
  <p>
    preference.xml
  </p>
  
  <pre class="syntax-highlight"><span class="synComment">&lt;?</span><span class="synType">xml version</span>=<span class="synConstant">"1.0"</span><span class="synType"> encoding</span>=<span class="synConstant">"utf-8"</span><span class="synComment">?&gt;</span>
<span class="synIdentifier">&lt;PreferenceScreen </span>
<span class="synType">xmlns</span><span class="synComment">:</span><span class="synType">android</span>=<span class="synConstant">"http://schemas.android.com/apk/res/android"</span><span class="synIdentifier">&gt;</span>
<span class="synIdentifier">&lt;PreferenceCategory </span><span class="synType">android</span><span class="synComment">:</span><span class="synType">title</span>=<span class="synConstant">"title"</span><span class="synIdentifier">&gt;</span>
<span class="synIdentifier">&lt;Preference </span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">selectable</span>=<span class="synConstant">"false"</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">layout</span>=<span class="synConstant">"@layout/admob_preference"</span><span class="synIdentifier"> /&gt;</span>
<span class="synIdentifier">&lt;/PreferenceCategory&gt;</span>
<span class="synIdentifier">&lt;/PreferenceScreen&gt;</span></pre>
  
  <h4>
    パターン2(画面の最下部に表示)
  </h4>
  
  <p>
    <a class="hatena-fotolife" href="http://f.hatena.ne.jp/Sirokoix/20101121182139" target="_blank"><img class="hatena-fotolife" title="f:id:Sirokoix:20101121182139p:image" src="http://cdn-ak.f.st-hatena.com/images/fotolife/S/Sirokoix/20101121/20101121182139.png" alt="f:id:Sirokoix:20101121182139p:image" /></a>
  </p>
  
  <p>
    こちらは、addContentViewを使用してレイアウトを被せる方法です。常に画面の下部に広告が表示されます。普通にやると、広告と最後の設定項目が被ってしまいます。そのため、最後の設定項目には広告の縦幅分のダミーを入れます。
  </p>
  
  <p>
    dummy_preference.xml
  </p>
  
  <pre class="syntax-highlight"><span class="synComment">&lt;?</span><span class="synType">xml version</span>=<span class="synConstant">"1.0"</span><span class="synType"> encoding</span>=<span class="synConstant">"utf-8"</span><span class="synComment">?&gt;</span>
<span class="synIdentifier">&lt;View</span>
<span class="synType">xmlns</span><span class="synComment">:</span><span class="synType">android</span>=<span class="synConstant">"http://schemas.android.com/apk/res/android"</span>
<span class="synType">xmlns</span><span class="synComment">:</span><span class="synType">myapp</span>=<span class="synConstant">"http://schemas.android.com/apk/res/sample"</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">id</span>=<span class="synConstant">"@+id/aaaid"</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">layout_width</span>=<span class="synConstant">"fill_parent"</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">layout_height</span>=<span class="synConstant">"50dp"</span><span class="synIdentifier">/&gt;</span></pre>
  
  <p>
    preference.xml
  </p>
  
  <pre class="syntax-highlight"><span class="synComment">&lt;?</span><span class="synType">xml version</span>=<span class="synConstant">"1.0"</span><span class="synType"> encoding</span>=<span class="synConstant">"utf-8"</span><span class="synComment">?&gt;</span>
<span class="synIdentifier">&lt;PreferenceScreen </span>
<span class="synType">xmlns</span><span class="synComment">:</span><span class="synType">android</span>=<span class="synConstant">"http://schemas.android.com/apk/res/android"</span><span class="synIdentifier">&gt;</span>
<span class="synIdentifier">&lt;PreferenceCategory </span><span class="synType">android</span><span class="synComment">:</span><span class="synType">title</span>=<span class="synConstant">"title"</span><span class="synIdentifier">&gt;</span>
<span class="synIdentifier">&lt;Preference</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">key</span>=<span class="synConstant">"key"</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">title</span>=<span class="synConstant">"title0"</span><span class="synIdentifier"> /&gt;</span>
<span class="synIdentifier">&lt;/PreferenceCategory&gt;</span>
<span class="synIdentifier">&lt;Preference </span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">selectable</span>=<span class="synConstant">"false"</span>
<span class="synType">android</span><span class="synComment">:</span><span class="synType">layout</span>=<span class="synConstant">"@layout/dummy_preference"</span><span class="synIdentifier"> /&gt;</span>
<span class="synIdentifier">&lt;/PreferenceScreen&gt;</span></pre>
  
  <p>
    MyActivity.java<br /> [java]<br /> public class MyActivity extends PreferenceActivity {<br /> @Override<br /> public void onCreate(Bundle savedInstanceState) {<br /> super.onCreate(savedInstanceState);<br /> addPreferencesFromResource(R.xml.preference);<br /> AdView adView = new AdView(this);<br /> adView.setVisibility(android.view.View.VISIBLE);<br /> adView.requestFreshAd();<br /> LayoutParams adLayoutParams = new LinearLayout.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.WRAP_CONTENT);<br /> adView.setLayoutParams(adLayoutParams);<br /> LinearLayout linearlayout = new LinearLayout(this);<br /> linearlayout.addView(adView);<br /> linearlayout.setGravity(Gravity.BOTTOM);<br /> LayoutParams layoutParams = new LinearLayout.LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.FILL_PARENT);<br /> addContentView(linearlayout, layoutParams);<br /> }<br /> }<br /> [/java]
  </p>
</div>
