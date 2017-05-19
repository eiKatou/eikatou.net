---
title: Datastoreに格納されたEntityの更新について
author: eiKatou
type: post
date: 2010-04-07T14:20:00+00:00
url: /11.html
categories:
  - GAE

---
<div class="section">
  <p>
    <a href="http://d.hatena.ne.jp/arashi77/20100214/1266117394" target="_blank">Datastoreに格納されたEntityの更新について &#8211; おきらく日記</a>
  </p>
  
  <p>
    Datastoreに格納されたEntityの更新について、興味深い記事を発見。
  </p>
  
  <pre class="syntax-highlight">
MyModelMeta meta = MyModelMeta.get();
MyModel model = Datastore.query(meta)
.filter(meta.field.equal(<span class="synConstant">&#34;value&#34;</span>))
.asSingle();
<span class="synStatement">if</span>(model != <span class="synConstant">null</span>) {
model.setField(<span class="synConstant">&#34;newValue&#34;</span>);
Datastore.put(model);
}
</pre>
  
  <p>
    これは、ダメだという事。どうするかというと、Keyでgetして、値を変えて、putする。
  </p>
  
  <pre class="syntax-highlight">
MyModel model = Datastore.get(MyModel.<span class="synType">class</span>, key.get(<span class="synConstant"></span>));
model.setField(<span class="synConstant">&#34;newValue&#34;</span>);
Datastore.put(model);
</pre>
  
  <p>
    queryで取得したEntityをなぜputしていけないのか、なかなか分からなかった。「検索して取得したものと実際に格納されてるものって別だもの」ってどういう事・・？
  </p>
  
  <p>
  </p>
  
  <p>
    調べたところ、トランザクション内でqueryは使えないんじゃないかという結果にたどり着いた。
  </p>
  
  <p>
    <a href="http://code.google.com/intl/ja/appengine/docs/java/datastore/transactions.html#What_Can_Be_Done_In_a_Transaction" target="_blank">トランザクション &#8211; Google App Engine &#8211; Google Code</a>
  </p>
  
  <blockquote>
    <p>
      アプリケーションは、トランザクション実行中にクエリを実行できません。しかし、トランザクション中にキーを使用してデータストア エンティティを取得することは可能です。このとき、フェッチされたエンティティは他のトランザクションの内容と一致していることを保証します。トランザクション実行前にキーを準備するか、キー名または ID を使用してトランザクション内にキーを構築できます。
    </p>
  </blockquote>
  
  <p>
    <a href="http://d.hatena.ne.jp/bluerabbit/20091204/1259947642" target="_blank">appengine java night #3に行ってきた。 #appengine #ajn3 &#8211; あおうさ＠日記</a>
  </p>
  
  <blockquote>
    <p>
      transaction 開始後最初のget/putで そのときのタイムスタンプをどこかに取っておく．
    </p>
    
    <p>
      commit のときに取っておいたタイムスタンプと同じかどうかを比較する．
    </p>
    
    <p>
      ancestor query 以外のqueryではtransactionがかからない．keyに対するgetだとだいtransactionになる．
    </p>
    
    <p>
      queryは本来複数の行を相手にしているので，そもそもどのentityグループにぞくしたqueryなのか定義できないから．
    </p>
    
    <p>
      ancestor queryは entity groupに対するqueryなので，定義できるから．
    </p>
  </blockquote>
  
  <p>
    Entityを更新する時は、keyでgetしてputする！
  </p>
</div>
