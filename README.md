# eikatou.net
eikatou.netのソースです

# テーマの設定
https://github.com/halogenica/beautifulhugo
/themes/ディレクトリに配置。以下のファイルを編集。

cp -p /themes/beautifulhugo/static/css/main.css /static/css/

/static/css/main.cssの以下を変更。
```css
body {
  /*font-family: 'Lora', 'Times New Roman', serif;*/
  font-size: 18px;
```
# 公開
/public/ディレクトリに出力される。