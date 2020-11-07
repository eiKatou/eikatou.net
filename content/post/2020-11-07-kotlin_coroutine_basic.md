---
title: "Kotlin 1.3 Coroutineの基礎を学ぶ"
date: 2020-11-07T11:19:11+09:00
author: eiKatou
type: post
url: /20201107.html
archives:
  - 2020
tags:
  - Kotlin
---

[![Kotlin Logo](/uploads/logo/kotlin.png)](https://www.jetbrains.com)

Kotlinの勉強を進めている中で、1.3で導入されたCoroutineが気になっていたので、基礎を勉強。runBlockingが何なのか分かるぐらいになった。

<!--more-->

# 参考資料

2つ目のリンクの日本語訳を見て進めることにした。

- [Coroutines Guide - Kotlin Programming Language](https://kotlinlang.org/docs/reference/coroutines/coroutines-guide.html)
- [kotlinx.coroutines/coroutines-guide.md at japanese_translation · pljp/kotlinx.coroutines](https://github.com/pljp/kotlinx.coroutines/blob/japanese_translation/docs/coroutines-guide.md)

# Basic

## runBlocking

> `runBlocking` を呼び出すメインスレッドは、`runBlocking` 内のコルーチンが完了するまで *ブロック* します。

```kotlin
fun main() { 
    // hogehoge
    runBlocking {     // しかし、この式はメインスレッドをブロックします
      	delay(2000L)  // ... 2秒間遅延してJVMを存続させる
    } 
}

// 上の書き方は、以下のように書ける。
fun main() = runBlocking<Unit> {
		delay(2000L)
}
```

## joinでGlobalScopeのコルーチンの終了を待つ

```kotlin
fun main() = runBlocking<Unit> {
    val job = GlobalScope.launch { // 新しいコルーチンを起動し、そのJobへの参照を保持する
      	// hoge
    }
  	job.join()
}
```

runBlockingの中でGlobalScopeのコルーチンを起動した場合、コルーチンの終了を待ってあげる必要がある。待つ方法はjoin()を使えばいい。

## GlobalScopeではなくrunBlockingのスコープ

> `GlobalScope.launch` を使うと、トップレベルのコルーチンが作成されます。 軽量であるにもかかわらず、実行中にいくらかのメモリリソースを消費します。

> より良い解決策があります。私たちのコードでは、構造化並行性を使用できます。 [GlobalScope](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-global-scope/index.html)でコルーチンを起動するのではなく、通常はスレッド（スレッドは常にグローバル）と同様に、実行中の操作の特定の範囲でコルーチンを起動することができます。

```kotlin
fun main() = runBlocking<Unit> {
    val job = GlobalScope.launch { // 新しいコルーチンを起動し、そのJobへの参照を保持する
      	// hoge
    }
  	job.join()
}

// 上の書き方を変更する
fun main() = runBlocking<Unit> { // this: CoroutineScope
    launch { // runBlockingのスコープで新しいコルーチンを起動
				// hoge
    }
}
```

runBlockingのスコープ内のコルーチンだからjoinで待たなくても良い。

## Scope builder

> [coroutineScope](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-coroutine-scope/index.html)ビルダーを使用して独自のスコープを宣言することも可能です。 これはコルーチンスコープを作成し、起動したすべての子が完了するまで完了しません。 [runBlocking](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/run-blocking.html)と[coroutineScope](https://kotlin.github.io/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/-coroutine-scope/index.html)の主な違いは、後者はすべての子が完了するのを待つ間、現在のスレッドをブロックしないことです。

```kotlin
fun main() = runBlocking<Unit> { // this: CoroutineScope
  	coroutineScope { // コルーチンスコープを作る
        launch {
            // hoge
        }
    }
}
```

runBlockingもcoroutineScopeも子の実行を待つ。ただし、runBlockingは呼び出し元のスレッドをブロックする。Blockingという名前の通り。coroutineScopeは呼び出し元のスレッドをブロックしない。

自分で管理する複数のスコープを宣言できる？後で調べる。

## Coroutines ARE light-weight

repeatって何？

```kotlin
repeat(100_000){
  // hoge
}
```

繰り返して実行するための高階関数。[repeat - Kotlin Programming Language](https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/repeat.html)

