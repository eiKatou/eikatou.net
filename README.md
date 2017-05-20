# eikatou.net
eikatou.netのソースです

# テーマの設定
https://github.com/halogenica/beautifulhugo
/themes/ディレクトリに配置。以下のファイルを編集。

```bash
mkdir -p ./static/css/
cp -p ./themes/beautifulhugo/static/css/main.css ./static/css/
cat ./themes/beautifulhugo/static/css/pygment_highlights.css >> ./static/css/main.css
cat ./themes/beautifulhugo/static/css/highlight.min.css >> ./static/css/main.css
mkdir -p ./layouts/partials/
cp -p ./themes/beautifulhugo/layouts/partials/head.html ./layouts/partials/
cp -p ./themes/beautifulhugo/layouts/partials/footer.html ./layouts/partials/
mkdir -p ./static/js/
cp -p ./themes/beautifulhugo/static/js/main.js ./static/js/
cat ./themes/beautifulhugo/static/js/highlight.min.js >> ./static/js/main.js
```

/static/css/main.cssの以下を変更。
```css
body {
  /*font-family: 'Lora', 'Times New Roman', serif;*/
  font-size: 18px;
```

./layouts/partials/head.htmlを以下のように修正
```html
<!--  <link rel="stylesheet" href="{{ "css/pygment_highlights.css" | absURL }}" />
  <link rel="stylesheet" href="{{ "css/highlight.min.css" | absURL }}" /> -->
```

./layouts/partials/footer.htmlを以下のように修正
```html
<!--<script src="{{ "js/highlight.min.js" | absURL }}"></script>-->
```

markdown記法でリンクをtarget="_blank"にする。
```javascript
// markdown記法でリンクをtarget="_blank"にする
<script language="JavaScript">
$(document).ready( function () {
   $("a[href^='http']:not([href*='" + location.hostname + "'])").attr('target', '_blank');
})
</script>

{{- partial "footer_custom.html" . }}
```

# 公開
/public/ディレクトリに出力される。