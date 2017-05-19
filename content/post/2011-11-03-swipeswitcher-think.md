---
title: SwipeSwitcherを作った理由
author: eiKatou
type: post
date: 2011-11-03T00:09:20+00:00
url: /154.html
tags:
  - Android
  - App
  - Dev

---
[<img src="http://eikatou.net/blog/wp-content/uploads/2011/11/icon.png" alt="" title="icon" width="72" height="72" class="alignnone size-full wp-image-168" />][1]

SwipeSwitcherを作った理由を説明する。
  
開発した意図を知って欲しいからだ。また、「SwipePadと比較されたくない」という想いがある。SwipePadとは別物だと思っているが、Androidマーケットに比較コメントが書かれてしまった。そこを説明したい。

<!--more-->

### SwipeSwitcherを作ろうと思ったきっかけ

「簡単にアプリ切替をしたい」という想いが、開発のきっかけとなった。アプリ切替は、「ホームボタン長押し > アプリ選択」からできるが、それすらも省略したかった。一瞬で、切替できるようにしたかった。
  
タスク切替を簡単に起動する方法として、スワイプする方法になった。そして、アプリ作成過程で、他アプリを起動するオプションをつけることにした。

### SwipePadとSwipeSwitcherの比較について

メイン機能に大きな違いがある。それを説明する。

#### SwipePadの機能

SwipePadの機能は以下である。

  * アプリ登録できるランチャー
  * スワイプ動作でランチャー起動
  * Addonにより機能拡張が可能

メインの機能は、”アプリ登録できるランチャー”である。

#### SwipeSwitcherの機能

SwipeSwitcherの機能は以下である。

  * アプリ切替の機能（一つ前のアプリに戻る）
  * スワイプ動作で登録アクションを起動
  * 登録アクションは、アプリ切替とアプリ起動

メインの機能は、”アプリ切替（一つ前に戻る）”である。デフォルト設定も、アプリ切替になっている。

### 最後に

SwipePadは非常に良く出来ているアプリで、開発者は本当にすごいと思う。初めて使ったときは驚いたし、すぐにAddonも買った。

スワイプの機能が似ているため、同じようなアプリとして認識されてしまうのかもしれない。しかし、ランチャーアプリとしてではなく、タスク切替アプリとして認識して欲しい。
  
その認識で、SwipeSwitcherを利用してもらえれば、とてもうれしく思う。

 [1]: http://eikatou.net/blog/wp-content/uploads/2011/11/icon.png