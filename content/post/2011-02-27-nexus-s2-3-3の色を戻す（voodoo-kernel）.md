---
title: Nexus S(2.3.3)の色を戻す（Voodoo kernel）
author: eiKatou
type: post
date: 2011-02-27T10:37:01+00:00
url: /60.html
categories:
  - Android

---
<div class="section">
  <p>
    Nexus SをAndroid 2.3.3にアップデートしたら、色合いが変わってしまいました。全体的に白色が強くなり、黄色っぽくなってしまった。<a href="http://www.androidcentral.com/nexus-s-233-update-bringing-unwanted-screen-issues" target="_blank">ここの写真</a>のような感じです。
  </p>
  
  <p>
    あまりにも色が汚いので、なんとか色を戻す方法を探っていました。結局、Voodoo kernelを入れることで、以前のような色にする事ができました。
  </p>
  
  <ul>
    <li>
      <a href="http://forum.xda-developers.com/showthread.php?t=876132" target="_blank"> &#91;KERNEL&#93; Voodoo kernel for Nexus S. AOSP+Voodoo improvements only, always updated &#8211; xda-developers</a>
    </li>
    <li>
      <a href="http://forum.xda-developers.com/showthread.php?t=949292" target="_blank"> &#91;KERNEL&#93;&#9734;Jame Bond&#9734;NS+NS4G w/BLN,ext4 & full voodoo (cm7-1.5.9,stk-1.5.9) &#8211; xda-developers</a>
    </li>
  </ul>
  
  <p>
    <a href="http://f.hatena.ne.jp/Sirokoix/20110227193538" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/S/Sirokoix/20110227/20110227193538.png" alt="f:id:Sirokoix:20110227193538p:image:w400" title="f:id:Sirokoix:20110227193538p:image:w400" class="hatena-fotolife" width="400" /></a>
  </p>
  
  <p>
    また、このROMには、専用のコントロールアプリ（<a href="https://market.android.com/details?id=org.projectvoodoo.controlapp" target="_blank">Voodoo Control App</a>）があります。
  </p>
  
  <p>
    <a href="http://f.hatena.ne.jp/Sirokoix/20110227191942" class="hatena-fotolife" target="_blank"><img src="http://cdn-ak.f.st-hatena.com/images/fotolife/S/Sirokoix/20110227/20110227191942.png" alt="f:id:Sirokoix:20110227191942p:image" title="f:id:Sirokoix:20110227191942p:image" class="hatena-fotolife" /></a>
  </p>
  
  <p>
    <a href="https://market.android.com/details?id=org.projectvoodoo.controlapp" target="_blank">Voodoo Control App</a>を起動すると、上の画像のように色の設定ができます。オリジナル（2.3.2）の色とVoodooの色を選べます。オリジナル（2.3.2）の色は黒に青が入っています。Voodoo Profileの色は正確なグレーでした。
  </p>
</div>
