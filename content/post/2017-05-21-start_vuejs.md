---
archives:
- 2017
author: eiKatou
date: 2017-05-21T13:14:54+09:00
tags:
- Dev
- Vue.js
title: "Vue.jsを始めました"
type: post
url: /20170521.html
---

![Vue.js Logo](/uploads/logo/vue.png)

# Vue.jsとは
Vue.jsは最近注目されているJavaScriptフレームワーク。シンプルさがうりである。  
[Vue.js](https://jp.vuejs.org/v2/guide/index.html)

<!--more-->

Angular.jsを勉強していたが、なかなか物が作れるようにならなくて少し飽きてきたところにで、Vue.jsを見つけて飛びついたという流れ。他のフレームワークとの比較は、以下の記事がわかりやすかった。  
[Backbone.JSからAngular2まで、全9大JavaScriptフレームワークを書き比べた!](http://paiza.hatenablog.com/entry/2015/03/11/Backbone_JS%E3%81%8B%E3%82%89Angular2%E3%81%BE%E3%81%A7%E3%80%81%E5%85%A89%E5%A4%A7JavaScript%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0%E3%83%AF%E3%83%BC%E3%82%AF%E3%82%92%E6%9B%B8%E3%81%8D%E6%AF%94%E3%81%B9)


# Vue.jsをはじめる
Vue.jsをはじめるには、本家のガイドを読むのが一番いいと思った。  
[Vue.js はじめに](https://jp.vuejs.org/v2/guide/)

日本語の情報がそろっており、分かりやすい。日本語のドキュメントがあるだけで印象良し！ここが英語のサイトだと、学習するのに時間がかかってしまう。

# 基本的な使い方のまとめ
[Vue.jsのガイド](https://jp.vuejs.org/v2/guide/)を順に読んで見て、使い方がわかってきた。ただ、ちょっと文章が多すぎて、初めの方にやったことを忘れてしまった。ここで、自分なりにまとめてみようと思う（ドキュメントを読んだ人向け）。

## 基本形
```html
<!DOCTYPE html>
<html>
  <head>
    <title>Vue hello world.</title>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue"></script>
  </head>
  <body>
    <div id="app">
      {{ message }}
    </div>
    <script type="text/javascript">
      var app = new Vue({
        el: '#app',
        data: {
          message: 'Hello Vue!'
        },
        methods: {
          hoge: function() {
            foo1();
          }
        },
        computed: {
          hoge: function() {
            foo2();
          }
        },
        watch: {
          hoge: function() {
            foo3();
          }
        },
      })
    </script>
  </body>
</html>
```

## ディレクティブ
HTMLの属性に紐づけて、HTMLを操作できる。  
参考：[API ディレクティブ](https://jp.vuejs.org/v2/api/#ディレクティブ)

ディレクティブ | 役割
--- | ---
v-text|HTMLタグに値を設定する
v-bind|HTMLタグの属性値を設定する
v-if,v-else,v-elseif|条件によって描写する
v-for|条件によって繰り返し描写する
v-on|イベントがあるとメソッドを呼び出す
v-model|値を保持し、入力と出力で利用する


## プロパティ
Vueオブジェクトに設定できるオプション。  
参考：[API オプション](https://jp.vuejs.org/v2/api/#オプション-データ)

プロパティ | 役割
--- | ---
el | どの要素と紐づけるか？
template | HTMLテンプレートを設定する
data|データを保持する
methods|メソッドを格納する
computed|値を算出するメソッド
watch|データの変更を監視して反応するメソッド

## コンポーネント
自分でHTMLタグを作成できる。
```
<div id="example">
  <my-component></my-component>
</div>
```
```javascript
// 登録する
Vue.component('my-component', {
  template: '<div>A custom component!</div>'
})
// root インスタンスを作成する
new Vue({
  el: '#example'
})
```

## ルーティング
ルーティングは、[vue-router 2](https://router.vuejs.org/ja/)を使うみたい。こちらも日本語ドキュメントあり。ありがたい！

## ガイドを終えて
一通りルーティングまで分かるようになったので、次はSPAの画面を作ってみたい。バックエンドは[Severless framework](https://github.com/serverless/serverless)を使って、AWSのAPI Gateway＋Lambdaで。これに認証機能をつければ、Webアプリケーションができる。