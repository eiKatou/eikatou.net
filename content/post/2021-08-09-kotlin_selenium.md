---
title: "KotlinでSeleniumを使ってChromeを操作する"
date: 2021-08-09T07:09:22+09:00
author: eiKatou
type: post
url: /20210809.html
archives:
  - 2021
tags:
  - Kotlin
---

SBI証券の入出金履歴を手軽に取りたいと思いつき、Kotlinプログラムからブラウザ操作を試した。結果から言うと、SBI証券の入出金履歴は手動で取ることにしました。なので、ほんの触りのところだけをやりました。

<!--more-->

# 環境
```bash
$ sw_vers
ProductName:    macOS
ProductVersion: 11.3.1
BuildVersion:   20E241

$ /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome -version
Google Chrome 92.0.4515.131
```

# やり方
Chrome Driverを落としてきてプロジェクトの中に入れる。version 92.0.4515.107をダウンロード。
[Downloads - ChromeDriver - WebDriver for Chrome](https://sites.google.com/a/chromium.org/chromedriver/downloads)


build.gradle.ktsに以下のように書いて、依存関係を追加。
```java
implementation("org.seleniumhq.selenium:selenium-java:3.141.59")
```

プログラムはこんな感じ。
```java
System.setProperty("webdriver.chrome.driver", "./driver/chromedriver")
val driver = ChromeDriver()
driver.get("https://www.yahoo.co.jp/")
runBlocking {
    delay(5000L)
}
driver.quit()
```

プログラムを実行するとChromeが立ち上がって、Yahooのページが表示されます。5秒後にブラウザが閉じられます。

プログラム全体はGitHubにある。  
[example/selenium/kotlin-selenium at master · eiKatou/example · GitHub](https://github.com/eiKatou/example/tree/master/selenium/kotlin-selenium)

# SBI証券の入出金履歴について
SBI証券はログイン後に重要事項の確認画面が出てくることがある。それの対応をする手間がめんどくさいと思ったため。月1回はログインしているので、そのついでに入出金履歴をダウンロードすればいい。ということに気がついて、やっぱり手動でダウンロードすることにした。

ブラウザの自動化はいつか役に立つ気がするので、ブログに残しておく。