---
archives:
- 2017
author: eiKatou
date: 2017-06-07T05:54:12+09:00
tags:
- Dev
- Vue.js
title: "Vuexでつまづいたところ"
type: post
url: /20170607.html
---

![Vue.js todo](/uploads/2017/06/vue_todo-1.jpg)

TODO管理アプリ（[前回](/20170606.html)を参考）にVuexを適用したが、つまづいたポイントが何点かあった。

<!--more-->

# Stateのデータを参照する
公式サイト（[ゲッター · GitBook](https://vuex.vuejs.org/ja/getters.html)）にも書いてあるが、Stateのデータを参照するには、gettersを利用する。これでつまづくのは、公式サイトを読んでいない自分が悪い！

```javascript
method(this.$store.getters.newTodo)
```

# mapGettersとmapActions
これも公式サイトに書いてあるんだけど、mapGettersとmapActionsが分かっていなかった。  

"store.getters.doneTodosCount"でデータを参照する事もできるが、mapGetters（[ゲッター · GitBook](https://vuex.vuejs.org/ja/getters.html)）を使用すると、"this.doneCount"でアクセスできるようになる。

```javascript
...mapGetters({
  doneCount: 'doneTodosCount'
})
```

"this.$store.dispatch('increment')"でStateのアクションを呼び出すのだが、mapActions（[アクション · GitBook](https://vuex.vuejs.org/ja/actions.html)）を使用すると、"this.increment()"でアクションを呼び出すことができる。

```javascript
  methods: {
    ...mapActions([
      'increment' // this.increment() を this.$store.dispatch('increment') にマッピングする
    ]),
    ...mapActions({
      add: 'increment' // this.add() を this.$store.dispatch('increment') にマッピングする
    })
  }
```

# Getterで引数を受け取る
[ゲッター · GitBook](https://vuex.vuejs.org/ja/getters.html)では第2引数にGetterを渡しているが、第2引数にGetterを渡さないときは、以下のように書ける。
```javascript
const getters = {
  todoByIndex: state => index => {
    return state.all[index]
  }
}
```

# v-modelを使う
[フォームの扱い · GitBook](https://vuex.vuejs.org/ja/forms.html)で「双方向算出プロパティ」というのがある。Mutationに値を渡しているが、Actionに値を渡したいときは、どうするのだろう？一度、Stateに保存してから、Getterで取り出して、Actionに渡すのだろうか・・。

# Action、Mutationでの引数は1つ
Actionを呼び出すときの引数は1つとなる。

例えば、以下のようなActionがあったとして、第3引数のindexに値は入らない。
```javascript
  // コンポーネントからActionを呼び出す
  this.setTodo(this.editTodo, index)

  // Actionの定義
  // 第3引数のindexはundefinedとなる
  setTodo ({commit}, todo, index) {
    commit(types.RECEIVE_SETTODO, todo, index)
  }
```

以下のように修正する。Mutationの呼び出しも同じで、第2引数までとする。
```javascript
  // コンポーネントからActionを呼び出す
  this.setTodo({todo: this.editTodo, index: index})

  // Actionの定義
  setTodo ({commit}, { todo, index }) {
    commit(types.RECEIVE_SETTODO, {todo: todo, index: index})
  }

  // Mutationの定義
  [types.RECEIVE_SETTODO] (state, {todo, index}) {
    state.all.splice(index, 1, todo)
  }
```


