# eikatou.net
eikatou.netのソースです

# 使い方

## ブログ記事を作成
```bash
cd /Users/ei/GitHub/eikatou.net
POSTNAME=goodby_wordpress
hugo new post/`date +%Y-%m-%d`-${POSTNAME}.md
```

## テーマ指定でサーバを起動
```bash
hugo server --theme=beautifulhugo --buildDrafts
```

以下でローカルモードにアクセス  
http://localhost:1313/blog/

## 公開
GitHubにプッシュ
```bash
./blog_publish.sh
```

# テーマの設定
https://github.com/halogenica/beautifulhugo  
/themes/ディレクトリに配置。

## headerとfooterの修正のためコピー
```bash
mkdir -p ./layouts/partials/
cp -p ./themes/beautifulhugo/layouts/partials/head.html ./layouts/partials/
cp -p ./themes/beautifulhugo/layouts/partials/footer.html ./layouts/partials/
```

## CSSを一つにまとめる
```bash
mkdir -p ./static/css/
cp -p ./themes/beautifulhugo/static/css/main.css ./static/css/
cat ./themes/beautifulhugo/static/css/pygment_highlights.css >> ./static/css/main.css
cat ./themes/beautifulhugo/static/css/highlight.min.css >> ./static/css/main.css
```

./layouts/partials/head.htmlを以下のように修正
```html
<!--  <link rel="stylesheet" href="{{ "css/pygment_highlights.css" | absURL }}" />
  <link rel="stylesheet" href="{{ "css/highlight.min.css" | absURL }}" /> -->
```

## JSを一つにまとめる
```bash
mkdir -p ./static/js/
cp -p ./themes/beautifulhugo/static/js/main.js ./static/js/
cat ./themes/beautifulhugo/static/js/highlight.min.js >> ./static/js/main.js
```
./layouts/partials/footer.htmlを以下のように修正
```html
<!--<script src="{{ "js/highlight.min.js" | absURL }}"></script>-->
```

## 記事のフォントを変更
/static/css/main.cssの以下を変更。
```css
body {
  /*font-family: 'Lora', 'Times New Roman', serif;*/
  font-family: 'Open Sans', 'Helvetica Neue', Helvetica, Arial, sans-serif;
```

## markdown記法でリンクをtarget="_blank"にする。
footer.htmlに追加。
```javascript
// markdown記法でリンクをtarget="_blank"にする
<script language="JavaScript">
$(document).ready( function () {
   $("a[href^='http']:not([href*='" + location.hostname + "'])").attr('target', '_blank');
})
</script>

{{- partial "footer_custom.html" . }}
```

## terms.htmlのリンク切れに対応
```javascript
      <a href="{{ $.Site.BaseURL }}{{ $data.Plural }}/{{ $value.Name | urlize }}" class="list-group-item">
          {{ $value.Name }}<span class="badge">{{ $value.Count }}</span></a>
      {{ end }}
```

## index.htmlのタグのリンク切れに対応
```javascript
      <a href="{{ $.Site.BaseURL }}{{ $data.Plural }}/{{ $value.Name | urlize }}" class="list-group-item">
          {{ $value.Name }}<span class="badge">{{ $value.Count }}</span></a>
      {{ end }}
```
