# eikatou.net
eikatou.netのソースです

# 使い方

## ブログ記事を作成
```bash
/Users/ei/Documents/GitHub/eikatou.net
ls content/post | tail -4
POSTNAME=goodby_wordpress
hugo new post/`date +%Y-%m-%d`-${POSTNAME}.md
```
Command+Pでファイルを開く。

## 画像サイズ
横400pxまで。
スマホのスクショは縦600pxにする。

## 便利なサイト
- [スマホアプリ紹介](http://mama-hack.com/app-reach/)

## テーマ指定でサーバを起動
```bash
hugo server --theme=beautifulhugo --buildDrafts
```

以下でローカルモードにアクセス  
http://localhost:1313/blog/

## 公開
公開前にドラフトを消して、GitHubにプッシュ。
その後、S3に展開。
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
<script language="JavaScript">
$(document).ready( function () {
  if (location.hostname == "localhost" || location.hostname == "eikatou.net") {
    $("a[href^='http']:not([href*='" + location.hostname + "'])").attr('target', '_blank');
  }
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

```
37c37
< #<a href="{{ $.Site.BaseURL }}tags/{{ . | urlize }}">{{ . }}</a>&nbsp;
---
> #<a href="./{{ $.Site.LanguagePrefix }}/tags/{{ . | urlize }}">{{ . }}</a>&nbsp;

```

## index.htmlのタグのリンク切れに対応
```javascript
  {{ if .Params.tags }}
    <span class="post-meta">
    {{ range .Params.tags }}
      #<a href="{{ $.Site.BaseURL }}tags/{{ . | urlize }}">{{ . }}</a>&nbsp;
    {{ end }}
    </span>
  {{ end }}
```
```
< {{ range $key, $value := .Data.Terms.Alphabetical}}
< <a href="{{ $.Site.BaseURL }}{{ $data.Plural }}/{{ $value.Name | urlize }}" class="list-grou
p-item">
---
> {{ range $key, $value := .Data.Terms.ByCount }}
> <a href="{{ $.Site.LanguagePrefix }}/{{ $data.Plural }}/{{ $value.Name | urlize }}" class="l
ist-group-item">
```

## RSSのリンクを正しくする
2017/10/07 HUGO v0.29に上げた時の問題
https://github.com/eiKatou/eikatou.net/commit/87226828de4ed63b2b3828b208c5036c6e7b08c3
