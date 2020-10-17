---
title: "Ktorを使ってAPIを呼び出す"
date: 2020-10-17T22:30:00+09:00
author: eiKatou
type: post
url: /20201017.html
archives:
  - 2020
tags:
  - Dev
  - Kotlin
---

[![Kotlin Logo](/uploads/logo/kotlin.png)](https://www.jetbrains.com)

[Ktor](https://ktor.io/)を使ってAPIを呼び出す。Server側でAPIを提供するのがメインのようだが、Client側のコードもかけるようなので試してみた。

<!--more-->

今回のコードは、[GitHubのリポジトリ](https://github.com/eiKatou/Sample/tree/master/Kotlin/KtorClient)に入れている。呼び出すAPIは、[httpbin](https://httpbin.org/)を利用させていただいた。

# Kotlinのコード
## gradle.kts
ktor関係のライブラリを追加する。また、シリアライザとして利用するGSONを追加した。sl4j-simpleを追加するとログが出せる。

```gradle
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    kotlin("jvm") version "1.4.10"
    application
}
group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation(kotlin("stdlib"))
    implementation("io.ktor:ktor-client-cio:1.4.0")
    implementation("io.ktor:ktor-client-apache:1.4.0")
    implementation("io.ktor:ktor-client-gson:1.4.0")
    implementation("io.ktor:ktor-client-logging-jvm:1.4.0")
    implementation("org.slf4j:slf4j-simple:1.7.26")
}

tasks.withType<KotlinCompile>() {
    kotlinOptions.jvmTarget = "11"
}
application {
    mainClassName = "MainKt"
}
```

## Getメソッド（基本のパターン）
基本的な使い方。シリアライザでGSONを指定していると、APIの戻り値を自動でオブジェクトに変換してくれる。レスポンスはdata classで受け取ることができる。

```kotlin
fun callGetAPI() {
    runBlocking {
        val client = HttpClient(CIO) {
            install(Logging) {
                logger = Logger.DEFAULT
                level = LogLevel.ALL
            }
            install(JsonFeature) {
                serializer = GsonSerializer {
                    // .GsonBuilder
                    serializeNulls()
                    disableHtmlEscaping()
                    setFieldNamingPolicy(FieldNamingPolicy.LOWER_CASE_WITH_UNDERSCORES)
                }
            }
        }

        val message :HttpBinGetResponse = client.get("https://httpbin.org/get")

        println(message.args)
        println(message.headers["Host"])
        println(message.origin)
        println(message.url)

        client.close()
    }
}

data class HttpBinGetResponse(
    val args: Map<String, String>,
    val headers: Map<String, String>,
    val origin: String,
    val url: String)
```

## Getメソッド（ヘッダーのカスタマイズ）
HTTP headerをカスタマイズするには・・？と思ったら、簡単に変えられた。
```kotlin
val message :HttpBinGetResponse = client.request {
    url("https://httpbin.org/get")
    method = HttpMethod.Get
    headers.append("User-Agent", "iPhone")
}
```


## Getメソッド（ステータス確認）
普通、APIを呼び出したらHTTP Status Codeを確認すると思うんだけど・・。と思って、HTTP Status Codeを確認する方法を調べた。
```kotlin
val response = client.get<HttpResponse>("https://httpbin.org/get")

println(response.status)
val content = response.readText()
println(content)

val responseObj = Gson().fromJson(content, HttpBinGetResponse::class.java)
println(responseObj.headers["Host"])
```

でも、自分でデシリアライズするコードを書くのはめんどくさい・・。なので、例外をキャッチして例外処理する形で良さそう。
```kotlin
try {
    val message: HttpBinGetResponse = client.get("https://httpbin.org/status/500")

    println(message.args)
    println(message.headers["Host"])
    println(message.origin)
    println(message.url)
} catch (e :ServerResponseException) {
    println("status code:${e.response?.status?.value}")
}
```

## Postメソッド
Bodyをdata classで渡せるし、レスポンスもdata classで受け取れる。
```kotlin
fun callPostAPI() {
    runBlocking {
        val client = HttpClient(CIO) {
            install(Logging) {
                logger = Logger.DEFAULT
                level = LogLevel.ALL
            }
            install(JsonFeature) {
                serializer = GsonSerializer {
                    // .GsonBuilder
                    serializeNulls()
                    disableHtmlEscaping()
                    setFieldNamingPolicy(FieldNamingPolicy.LOWER_CASE_WITH_UNDERSCORES)
                }
            }
        }

        val message = client.post<HttpBinPostResponse> {
            url("http://httpbin.org/post")
            contentType(ContentType.Application.Json)
            body = HttpBinPostBody(
                data1 = "dog",
                data2 = "cat")
        }

        println(message)
        println("data1:${message.json["data1"]}, data2:${message.json["data2"]}")

        client.close()
    }
}

data class HttpBinPostBody(val data1: String, val data2: String)
data class HttpBinPostResponse(
    val args: Map<String, String>,
    val headers: Map<String, String>,
    val origin: String,
    val data: String,
    val json: Map<String, String>,
    val url: String)
```

# さいごに
外部APIを呼び出すことができたら、一気にKotlinアプリでできることが広がる。良い感じに使えるので、今後も使っていきたい。