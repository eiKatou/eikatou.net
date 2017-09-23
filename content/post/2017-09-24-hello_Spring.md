---
archives:
- 2017
author: eiKatou
date: 2017-09-24T06:24:14+09:00
tags:
- Dev
- Java
title: "Spring始めました"
type: post
url: /20170924.html
---

![Spring Logo](/uploads/logo/spring.png)

ようやく重い腰を上げて、Springを使い始めました。今までSeasarに頼ってきたのですが、そうは言ってられない状況（End Of Life）なので、Springに手を出し始めたわけです。

Springを始めた記念の投稿です。

<!--more-->

# Springとは
Webアプリケーションを作るためのフレームワーク。と思っていたけど、Webアプリケーションに限らないみたい。Spring Batchならば、バッチ処理を作ることもできる。

DIやAOP、ORマッパーを使うことができる。この辺りはSeasarで学んだ考え方を生かすことができそう。

# Spring Bootとは
Spring関係のプロジェクトは数多くあり、そのプロジェクトを簡単に使えるようにしてくれた簡単初期構築パックみたいな感じ。

[» Spring Boot 入門 TECHSCORE BLOG](http://www.techscore.com/blog/2014/05/01/spring-boot-introduction/)

    Spring Boot のサイトには「スタンドアロンで production-grade な Spring ベースのアプリケーションを簡単に作ることができる」と書かれており、以下の特徴が挙げられています。

    ・スタンドアロンな Spring アプリケーションを作ることができる。
    ・Tomcat や Jetty を直接組み込むので war ファイルのデプロイが不要。
    ・Maven の設定をシンプルにする 'starter' POM を提供してくれる。
    ・Spring を自動設定してくれる（できる限り）。
    ・本番用の機能（メトリクス、ヘルスチェック、設定の外部化など）を提供してくれる。
    ・コード生成や XML の設定が不要。


# 写経して気がついたこと
早速、以下の入門コースを写経してみた。色々と気がついた点があった。

- [» Spring Tool Suite (STS)と Spring Boot で始める Web アプリケーション開発（１） TECHSCORE BLOG](http://www.techscore.com/blog/2016/11/22/start-with-sts-and-spring-boot-1/)
- [» Spring Tool Suite (STS)と Spring Boot で始める Web アプリケーション開発（２） TECHSCORE BLOG](http://www.techscore.com/blog/2016/11/25/start-with-sts-and-spring-boot-2/)
- [» Spring Tool Suite (STS)と Spring Boot で始める Web アプリケーション開発（３） TECHSCORE BLOG](http://www.techscore.com/blog/2016/12/03/start-with-sts-and-spring-boot-3/)

Spring Legacyプロジェクトは、Springの基本的なプロジェクト（Spring Bootでない）を作るためにある。Spring Starterプロジェクトは、Spring Bootを利用するプロジェクトで使う。

Spring Bootプロジェクトの実行は、プロジェクトを右クリック ＞ [Run As] ＞ [Spring Boot App] で実行できる。スタンドアロンアプリのように見えるけど、Tomcatが内蔵されていてWebアプリとして実行できる。  
http://localhost:8080/

Spring Bootで作ったプロジェクトは、Tomcatなどのアプリケーションサーバで動かすwarファイルにできる。  
[Spring BootでWARを作成して別のTomcatにデプロイする - Qiita](http://qiita.com/NagaokaKenichi/items/3f191aeb6f161101d5f6)

    [Run As] > [6 Maven build] > Goalsに「package」を入力 > [Run]ボタン押下

Springの最新バージョンは5.0。  
[Spring Framework 5.0 主な変更点の概要 - Qiita](http://qiita.com/kazuki43zoo/items/1d5d09a5a70a6be696ac)

鉄板構成を覚えておく。

- HTMLテンプレートエンジン：Thymeleaf
- RDBアクセス：Spring Data JPA
- ロギング：SL4J + Logback