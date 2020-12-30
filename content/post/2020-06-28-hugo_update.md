---
title: "HUGOのアップデート v0.73.0"
date: 2020-06-28T09:03:25+09:00
author: eiKatou
type: post
url: /20200628.html
archives:
  - 2020
tags:
  - Web
---

![hugo_logo](/uploads/logo/hugo.jpg)

ようやくHUGOをアップデートした。v0.31.1からv0.73.0にアップデート。

<!--more-->

今後の自分のためにアップデートでした事をメモしておく。

# HUGOのアップデート
brewコマンドでアップデートするだけ。
```bash
brew update
brew info hugo
brew upgrade hugo
hugo version
```

# 自動更新に向けて
このブログのリポジトリ[eiKatou/eikatou.net](https://github.com/eiKatou/eikatou.net)をコミットしたら、自動で更新されるようにしたい。他のツールでビルド＆デプロイを自動化していて、メンテナンスが非常に簡単になった事を実感したので。[HUGOの更新作業をAWS CodeBuildを使って自動化する - Qiita](https://qiita.com/shigeru-yokochi/items/abf15bc37d7b93ef2bd8)が参考になりそう。

自動更新に近づけるため、個人PCへの依存を下げる形で修正。


# テーマの更新
今まで、テーマは[beautifulhugo](https://github.com/halogenica/beautifulhugo)を使っていて、リポジトリをcloneしてカスタマイズしていた。これをforkする形に変更。forkした[beautifulhugo - eiKatou](https://github.com/eiKatou/beautifulhugo)を利用するように変更。

テーマのカスタマイズを実施したのは以下の内容。
- フッターの日本語を修正
- タグやアーカイブページの一覧の並びをアルファベットの昇順に変更


# ブログ更新スクリプトの変更
更新スクリプト内で[beautifulhugo - eiKatou](https://github.com/eiKatou/beautifulhugo)リポジトリからコードを取得して使うように変更。
