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
hugo server --theme=beautifulhugo
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
github上でプルリクエストを作成。masterにマージ。その後S3に展開。
```bash
git checkout master
git branch -D issueXX_NAME
git pull
./blog_publish.sh
```

# テーマ
[beautifulhugo](https://github.com/halogenica/beautifulhugo)を別の場所にチェックアウトして、/themes/ディレクトリにシンボリックリンクを配置。

変更をコミットしている。差分を抽出したファイルを配置。  
/themes/beautifulhugo_diff.txt

# 便利なサイト
- [スマホアプリ紹介](http://mama-hack.com/app-reach/)
