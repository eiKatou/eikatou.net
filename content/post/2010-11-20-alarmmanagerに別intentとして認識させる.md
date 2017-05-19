---
title: AlarmManagerに別Intentとして認識させる
author: eiKatou
type: post
date: 2010-11-20T00:04:14+00:00
url: /49.html
tags:
  - Android
  - Dev

---
<div class="section">
  <p>
    AlarmManagerに別Intentとして認識させる方法です。<a href="http://labs.techfirm.co.jp/android/m_yamada/1844" target="_blank">ここ</a>のURLの内容とかぶるのですが、動かなくて悔しかったので、別の方法でやっています。
  </p>
  
  <h4>
    やりたいこと
  </h4>
  
  <p>
    Intentを定期的に送信してBroadcastReceiverを起動したい。でも、複数タイマーで起動したいので、タイマーを上書きされると困る。だから、別Intentとして認識して欲しい。
  </p>
  
  <p>
    方法としては、IntentのDataに別のURIを入れてタイマーにセットします。別の文字列を用意しないといけないので、現在時間などが良いと思います。
  </p>
  
  <h4>
    Step.1(AndroidManifest.xmlに追記)
  </h4>
  
  <pre class="syntax-highlight">
<span class="synIdentifier">&#60;receiver </span><span class="synType">android</span><span class="synComment">:</span><span class="synType">name</span>=<span class="synConstant">&#34;com.appspot.eikatou0.SampleReceiver&#34;</span><span class="synIdentifier"> </span>
<span class="synIdentifier">    </span><span class="synType">android</span><span class="synComment">:</span><span class="synType">label</span>=<span class="synConstant">&#34;@string/app_name&#34;</span><span class="synIdentifier">&#62;</span>
<span class="synIdentifier">&#60;intent-filter </span><span class="synType">android</span><span class="synComment">:</span><span class="synType">priority</span>=<span class="synConstant">&#34;0&#34;</span><span class="synIdentifier">&#62;</span>
<span class="synIdentifier">&#60;action </span><span class="synType">android</span><span class="synComment">:</span><span class="synType">name</span>=<span class="synConstant">&#34;ACTION&#34;</span><span class="synIdentifier">/&#62;</span>
<span class="synIdentifier">&#60;data </span><span class="synType">android</span><span class="synComment">:</span><span class="synType">scheme</span>=<span class="synConstant">&#34;SCHEME&#34;</span><span class="synIdentifier"> /&#62;</span>
<span class="synIdentifier">&#60;data </span><span class="synType">android</span><span class="synComment">:</span><span class="synType">host</span>=<span class="synConstant">&#34;HOSTNAME&#34;</span><span class="synIdentifier"> /&#62;</span>
<span class="synIdentifier">&#60;/intent-filter&#62;</span>
<span class="synIdentifier">&#60;/receiver&#62;</span>
</pre>
  
  <h4>
    Step.2(PendingIntentを作って、アラームに設定)
  </h4>
  
  <pre class="syntax-highlight">
<span class="synType">private</span> <span class="synType">void</span> start() {
PendingIntent pendingIntent = makePendingIntent(context);
alarmManager.setRepeating(AlarmManager.ELAPSED_REALTIME,
<span class="synConstant"></span>,
<span class="synConstant">1</span> * <span class="synConstant">60</span> * <span class="synConstant">1000</span>, <span class="synComment">// 1min * 60sec * 1000</span>
pendingIntent);
}
<span class="synType">private</span> PendingIntent makePendingIntent(Context context) {
Intent intent = <span class="synStatement">new</span> Intent();
intent.setAction(<span class="synConstant">&#34;ACTION&#34;</span>);
intent.setData(makeUri());
PendingIntent pendingIntent = PendingIntent
.getBroadcast(context, <span class="synConstant"></span>, intent, <span class="synConstant"></span>);
<span class="synStatement">return</span> pendingIntent;
}
<span class="synType">private</span> Uri makeUri() {
StringBuffer buffer = <span class="synStatement">new</span> StringBuffer();
<span class="synType">long</span> nowElapsedRealtime = SystemClock.elapsedRealtime();
buffer.append(<span class="synConstant">&#34;SCHEME&#34;</span> + <span class="synConstant">&#34;://&#34;</span>)
.append(<span class="synConstant">&#34;HOSTNAME&#34;</span> + <span class="synConstant">&#34;/&#34;</span>)
.append(Long.toString(nowElapsedRealtime));
Uri uri = Uri.parse(buffer.toString());
<span class="synStatement">return</span> uri;
}
</pre>
  
  <h4>
    参考
  </h4>
  
  <ul>
    <li>
      <a href="http://developer.android.com/reference/android/app/AlarmManager.html" target="_blank">AlarmManager | Android Developers</a>
    </li>
    <li>
      <a href="http://developer.android.com/reference/android/content/Intent.html#filterEquals%28android.content.Intent%29" target="_blank">Intent | Android Developers</a>
    </li>
    <li>
      <a href="http://labs.techfirm.co.jp/android/m_yamada/1844" target="_blank">AlarmManagerに異なるintentと認識させる方法 | Android Techfirm Lab</a>
    </li>
  </ul>
</div>
