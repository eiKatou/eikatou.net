# eikatou.net
eikatou.netのソースです

# ブログ記事を作成
```bash
/Users/ei/Documents/GitHub/eikatou.net
ls content/post | tail -4
POSTNAME=goodby_wordpress
hugo new post/`date +%Y-%m-DD`-${POSTNAME}.md
```
Command+Pでファイルを開く。

# テーマ指定でサーバを起動
```bash
./blog_localrun.sh
```

以下でローカルモードにアクセス  
http://localhost:1313/blog/

# ブランチの使い方
Control+Shift+@で統合ターミナルを開く。
```bash
git branch issueXX_NAME
git checkout issueXX_NAME
git status
git add -A
＜記事を書いて、ファイル名の日付を変える＞
git commit -m "記事を追加"
git log --oneline -5
git push origin issueXX_NAME
```
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
[beautifulhugo](https://github.com/halogenica/beautifulhugo)をforkした[beautifulhugo - eiKatou](https://github.com/eiKatou/beautifulhugo)を利用する。

テーマの開発をするときは、以下で起動すること。
```bash
hugo server --theme=beautifulhugo_dev
```

# 便利なサイト
- [スマホアプリ紹介](http://mama-hack.com/app-reach/)
