---
title: "実行可能jarを作成する (Gradle 7.1+Gradle Kotlin DSL)"
date: 2021-08-15T18:17:08+09:00
author: eiKatou
type: post
url: /20210815.html
archives:
  - 2021
tags:
  - Kotlin
---

自己満足プログラムを書いたときに、実行可能jarを作成する方法を調べた。

<!--more-->

# 環境
```bash
$ ./gradlew -version

------------------------------------------------------------
Gradle 7.1
------------------------------------------------------------

Build time:   2021-06-14 14:47:26 UTC
Revision:     989ccc9952b140ee6ab88870e8a12f1b2998369e

Kotlin:       1.4.31
Groovy:       3.0.7
Ant:          Apache Ant(TM) version 1.10.9 compiled on September 27 2020
JVM:          11.0.3 (Oracle Corporation 11.0.3+12-LTS)
OS:           Mac OS X 10.16 x86_64
```

# build.gradle.kts
以下を追記する。
```kotlin
// https://www.jetbrains.com/help/idea/create-your-first-kotlin-app.html#package-as-jar
tasks.jar {
    duplicatesStrategy = DuplicatesStrategy.EXCLUDE
    manifest {
        attributes["Main-Class"] = "com.example.MainKt"
    }
    configurations["runtimeClasspath"].forEach { file: File ->
        from(zipTree(file.absoluteFile))
    }
}
```

DuplicatesStrategyを入れないと以下のエラーとなる。
> What went wrong:
> 
> Execution failed for task ':jar'.
> Entry META-INF/versions/9/module-info.class is a duplicate but no duplicate handling strategy has been set. Please refer to https://docs.gradle.org/7.1/dsl/org.gradle.api.tasks.Copy.html#org.gradle.api.tasks.Copy:duplicatesStrategy for details.

Gradle 6.7では発生していなかったので、Gradleの挙動によるもののようだ。

# jarの作成
```bash
./gradlew clean jar
```

# 実行
```bash
java -jar build/libs/executable-jar-1.0-SNAPSHOT.jar
```

# 注意
実行可能なjarを作る時に注意しないといけないのがjarの依存関係。複雑な依存関係を持つプログラムの実行可能jarを作るために、昔かなり苦労した記憶がある。上記のやり方だけでは足りないかもしれない。でも、何かの参考になれば。

今回試したプログラムは以下にあります。
[example/Kotlin/executable-jar at master · eiKatou/example](https://github.com/eiKatou/example/tree/master/Kotlin/executable-jar)