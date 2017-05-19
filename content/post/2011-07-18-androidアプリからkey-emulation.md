---
title: AndroidアプリからKey emulation
author: eiKatou
type: post
date: 2011-07-18T02:28:41+00:00
url: /68.html
archives:
  - 2011
tags:
  - Android
  - Dev

---
<div class="section">
  <p>
    最近、Androidアプリからキー入力をエミュレーションさせる方法を調べていました。「ADBコマンドでキーを送信することができるので簡単にできるだろう」と思っていたら、難しかったです（スキル不足？）。
  </p>
  
  <p>
    リフレクションでWindowManagerのインスタンスを取得して、IWindowManager#injectKeyEventメソッド呼び出ししています。リフレクションだらけのコードは、あんまり使いたくないですね。
  </p>
  
  <h4>
    サンプルコード
  </h4>
  
  <p>
    [java]<br /> private void keyUpDown(int keycode) {<br /> ClassLoader loader = ClassLoader.getSystemClassLoader();<br /> try {<br /> Class serviceManagerClazz = loader.loadClass("android.os.ServiceManager");<br /> Method getServiceMethod = serviceManagerClazz.getMethod("getService", String.class);<br /> Object windowObj = getServiceMethod.invoke(null, "window");<br /> Class windowManagerStubClazz = loader.loadClass("android.view.IWindowManager$Stub");<br /> Method asInterfaceMethod = windowManagerStubClazz.getMethod("asInterface", IBinder.class);<br /> Object iwindowObj = asInterfaceMethod.invoke(null, windowObj);<br /> Class windowManagerClazz = loader.loadClass("android.view.IWindowManager");<br /> Method method = windowManagerClazz.getMethod("injectKeyEvent", KeyEvent.class, boolean.class);<br /> method.invoke(iwindowObj, new KeyEvent( KeyEvent.ACTION_DOWN, keycode), true);<br /> method.invoke(iwindowObj, new KeyEvent( KeyEvent.ACTION_UP, keycode), true);<br /> } catch (ClassNotFoundException e) {<br /> e.printStackTrace();<br /> } catch (SecurityException e) {<br /> e.printStackTrace();<br /> } catch (NoSuchMethodException e) {<br /> e.printStackTrace();<br /> } catch (IllegalArgumentException e) {<br /> e.printStackTrace();<br /> } catch (IllegalAccessException e) {<br /> e.printStackTrace();<br /> } catch (InvocationTargetException e) {<br /> e.printStackTrace();<br /> }<br /> }<br /> [/java]
  </p>
  
  <p>
    こんな感じです。Android 2.3ではHOMEキーは押せないので注意です。他のアプリにキー送信できるのかな・・??
  </p>
  
  <p>
    誰か、他にも良いやり方を知っていれば、教えてください。
  </p>
  
  <h4>
    参考
  </h4>
  
  <ul>
    <li>
      <a href="http://stachibana.biz/?p=427" target="_blank">Flex、AIR、Java、Androidなど » ※追記有り【Android】端末を振ってオプションメニューを出す</a>
    </li>
    <li>
      他にも多数・・（見つけきれなくてすみません）
    </li>
  </ul>
</div>
