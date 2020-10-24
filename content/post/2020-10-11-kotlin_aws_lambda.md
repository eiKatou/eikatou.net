---
title: "KotlinのコードをAWS Lambda上で動かす"
date: 2020-10-11T08:43:23+09:00
author: eiKatou
type: post
url: /20201011.html
archives:
  - 2020
tags:
  - AWS
  - Dev
  - Kotlin
---

<!--[![Kotlin Logo](/uploads/logo/kotlin.png)](https://www.jetbrains.com) -->

Kotlinで書いたコードをAWS Lambda上で動かしてみた。

AWS Lambdaには、クラスファイルを含めたzipファイルを上げる形にする。AWS SAMは前に使ったけど、今回はKotlin(Java)でどう動かすのか見たいだけなので、シンプルな方法にした。開発環境は[IntelliJ IDEA](https://www.jetbrains.com/ja-jp/idea/)を利用している。

<!--more-->
# Kotlinのコード
## gradle.kts
まずはgradle。zipファイルを作成するタスクを追加した。
最近はgradleもKotlinで書くようにしている。でも、いまだに書き方が分からない。。

```gradle
plugins {
    java
    kotlin("jvm") version "1.4.10"
}

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation(kotlin("stdlib"))
    implementation("org.slf4j:slf4j-simple:1.7.26")
    implementation("com.amazonaws:aws-lambda-java-core:1.2.1")
    implementation("com.amazonaws:aws-lambda-java-events:3.1.0")
    runtimeOnly("com.amazonaws:aws-lambda-java-log4j2:1.2.0")
//    testCompile("junit", "junit", "4.12")
}

tasks{
    // thank you: https://github.com/davidmerrick/aion/blob/master/build.gradle.kts

    val buildZip by creating(Zip::class) {
        from(compileKotlin)
        from(processResources)
        into("lib") {
            from(configurations.runtimeClasspath)
        }
    }

    compileKotlin {
        kotlinOptions {
            jvmTarget = "1.8"
        }
    }

    compileTestKotlin {
        kotlinOptions {
            jvmTarget = "1.8"
        }
    }
}
```

## Handler.kt
AWS Lambdaから呼び出されるコード。

```kotlin
import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.RequestHandler

// 参考
// https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/java-handler.html
// https://github.com/awsdocs/aws-lambda-developer-guide/tree/master/sample-apps/java-basic/src/main/java/example
class Handler : RequestHandler<Map<String, String>, String> {
    override fun handleRequest(input: Map<String, String>?, context: Context?): String {
        println(input.toString())
        return "lambda success."
    }
}
```

## AWS Lambdaで実行
AWS Lambdaに上げるためのzipを作成する。
```bash
./gradlew buildZip
```

実行すると、build/distributions/hoge-1.0-SNAPSHOT.zip が出来ているはず。AWSの管理コンソールからアップロードした。

設定は以下を設定した。以下のもの以外はデフォルトのまま。
- ランタイム: Java 11 (Corretto)
- ハンドラ: Handler::handleRequest

いざ実行！
![kotlin_lambda_run](/uploads/2020/10/kotlin_lambda_run.png)

特に何もつまるところなく、あっけなく実行できてしまった。今後、KotlinとAWS Labmdaでアプリ作っていこうかな。
