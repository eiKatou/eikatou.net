# eikatou.net
eikatou.netのソースです。

# ブログ記事を作成
```bash
ls content/post | tail -4
POSTNAME=goodby_wordpress
../bin/hugo.exe new post/`date +%Y-%m-%d`-${POSTNAME}.md
```
Control+Pでファイルを開く。

# ローカルで動作確認
```bash
./blog_win_localrun.sh
```

以下でローカルモードにアクセス  
http://localhost:1313/blog/

# ブランチの使い方
github上でプルリクエストを作成。masterにマージ。

# デプロイ
masterにpushすると、AWS CodeBuildで自動的にデプロイされる。ビルド結果はSlackに通知が来る。
設定はbuildspec.yml。

# 手動デプロイ
自分のPCに環境が設定されている必要がある。
```bash
git checkout master
git pull
./blog_publish.sh
```

# テーマ
[eiKatou/eikatou.net_theme](https://github.com/eiKatou/eikatou.net_theme)を利用する。

テーマの開発をするときは、blog_theme-devにリンクを作って、以下で起動すること。
```bash
rm -rf themes/eikatou.net_theme-dev
cp -rp ../eikatou.net_theme/ themes/eikatou.net_theme-dev
../bin/hugo.exe server --theme=eikatou.net_theme-dev
```

# 便利なサイト
- [スマホアプリ紹介](http://mama-hack.com/app-reach/)

