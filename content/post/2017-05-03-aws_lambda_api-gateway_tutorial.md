---
title: AWS：LambdaとAPI Gatewayを使ったチュートリアルを試す
author: eiKatou
type: post
date: 2017-05-03T14:37:44+00:00
url: /3390.html
archives:
  - 2017
tags:
  - AWS
  - Dev

---
![AWS Logo](/uploads/logo/aws.jpg)
  
AWSのLambdaのチュートリアルを試している。今回は、<a href="http://docs.aws.amazon.com/ja_jp/lambda/latest/dg/with-on-demand-https-example.html" target="_blank">Amazon API Gateway での AWS Lambda の使用 (オンデマンド HTTPS 経由) &#8211; AWS Lambda</a>をやってみた。意外とひっかかりまくったので、その記録。

今回、一番困ったのが、動作確認をするところ。ドキュメントには何も書かれていなくて、APIに何を投げれば良いのか不明だった。Node.jsもLambdaもあまり詳しくないので、非常に困ってしまった。

# 目的

目的は以下の通り。簡単に書くと「APIからLambda経由でDynamoDBをCRUDするぜ」という内容。

> この例では、Amazon API Gateway を使用してシンプルな API (DynamoDBOperations) を作成します。Amazon API Gateway はリソースとメソッドの集合体です。このチュートリアルでは、1 つのリソース (DynamoDBManager) を作成し、それに対する 1 つのメソッド (POST) を定義します。このメソッドでは-Lambda 関数 (LambdaFunctionForAPIGateway) が使用されます。つまり、HTTPS エンドポイントでメソッドを呼び出すと、Amazon API Gateway が Lambda 関数を呼び出します。 

<a href="http://docs.aws.amazon.com/ja_jp/lambda/latest/dg/with-on-demand-https-example.html" target="_blank">Amazon API Gateway での AWS Lambda の使用 (オンデマンド HTTPS 経由) &#8211; AWS Lambda</a>を参考にして進めていく。

<!--more-->

# Dynamoの準備
Dynamoのテーブルを準備しておく。以下のテーブルを用意した。

 - テーブル名：Game
 - 主キー：UserId
 - 属性：Favorite
 - 属性：Title
 - 属性：Wins 

# Lambdaの作成

<a href="http://docs.aws.amazon.com/ja_jp/lambda/latest/dg/with-on-demand-https-example-create-test-manually.html" target="_blank">ステップ 2: Lambda 関数を作成し、手動でテストする &#8211; AWS Lambda</a>
  
この項目は実行せずに、Web画面から設計図「microservice-http-endpoint」を選択して、順にクリックで進んでいく。チュートリアルでは前のバージョンで書かれているが、現時点ではnodejs 6.10のバージョンが選択できる。

以下のコードでLambdaが作られる。21行目のconsole.logはコメントアウトを外した。

```node
'use strict';

console.log('Loading function');

const doc = require('dynamodb-doc');

const dynamo = new doc.DynamoDB();


/**
 * Demonstrates a simple HTTP endpoint using API Gateway. You have full
 * access to the request and response payload, including headers and
 * status code.
 *
 * To scan a DynamoDB table, make a GET request with the TableName as a
 * query string parameter. To put, update, or delete an item, make a POST,
 * PUT, or DELETE request respectively, passing in the payload to the
 * DynamoDB API as a JSON body.
 */
exports.handler = (event, context, callback) => {
    console.log('Received event:', JSON.stringify(event, null, 2));

    const done = (err, res) => callback(null, {
        statusCode: err ? '400' : '200',
        body: err ? err.message : JSON.stringify(res),
        headers: {
            'Content-Type': 'application/json',
        },
    });

    switch (event.httpMethod) {
        case 'DELETE':
            dynamo.deleteItem(JSON.parse(event.body), done);
            break;
        case 'GET':
            dynamo.scan({ TableName: event.queryStringParameters.TableName }, done);
            break;
        case 'POST':
            dynamo.putItem(JSON.parse(event.body), done);
            break;
        case 'PUT':
            dynamo.updateItem(JSON.parse(event.body), done);
            break;
        default:
            done(new Error(`Unsupported method "${event.httpMethod}"`));
    }
};
```


# Lambdaのテスト実行

Lambdaの管理コンソールから、以下のJSONを投げてテスト実行する。

```json
{
	"httpMethod": "GET",
	"queryStringParameters": {
	"TableName": "Game"
    }
}
```

# API Gateway経由でLambdaを呼び出し

## APIのデプロイ

いきなりAPIを呼び出すと、「Internal Server Error」が返ってくる。API Gatewayを使う前にデプロイしておく必要がある。
  
<img src="/uploads/2017/05/170503-0001.jpg" alt="" width="600" height="237" class="alignnone size-full wp-image-3401" srcset="/uploads/2017/05/170503-0001.jpg 600w, /blog/uploads/2017/05/170503-0001-300x119.jpg 300w, /blog/uploads/2017/05/170503-0001-500x198.jpg 500w" sizes="(max-width: 600px) 100vw, 600px" />

APIのURLを覚えておく。ここでは以下のようなURLだったとして記述する。
  
https://api.ap-northeast-1.amazonaws.com/prod/simple_backend

## Postmanのインストール

<a href="https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=ja" target="_blank">Postman &#8211; Chrome ウェブストア</a>を利用してAPIを呼び出す。APIには認証がかかっているため、AuthorizationでAWS Signatureを選択し、AccessKey、SecretKey、AWS Regionを入力、Service Nameは&#8221;execute-api&#8221;を入れること。

## GETメソッド

URLパラメータで渡した内容が、queryStringParametersで入るようだ。以下のようなURLでGETする。Gameテーブルの内容が全て返ってくる。
  
https://api.ap-northeast-1.amazonaws.com/prod/simple_backend?TableName=Game 

## POSTメソッド

PostmanのBodyでrawを選択すると、JSONが選択できる。以下のJSONをURLに対して投げる。すると、DynamoDBにデータが入っていることが確認できる。

```json
{
  "TableName": "Game",
  "Item": {
    "UserId": "201",
    "Title": "Big Echo",
    "Favorite": "Stage2",
    "Wins": 3
  }
}
```

## PUTメソッド

以下のJSONをURLに対して投げると、DynamoDBのデータが更新される。

```json
{
  "TableName": "Game",
  "Key" : {
      "UserId": "201"
  },
  "UpdateExpression": "set Title = :t, Wins = :w",
  "ExpressionAttributeValues" : {
      ":t":"Big Echo2",
      ":w":4
  },
  "ReturnValues" : "UPDATED_NEW"
}
```

## DELETEメソッド

以下のJSONをURLに対して投げると、DynamoDBのデータが削除される。

```json
{
  "TableName": "Game",
  "Key" : {
      "UserId": "201"
  }
}
```

## Node.jsとDynamoDB

上記のJSONは、Node.jsでDynamoDBを操作するときのAPIを参考にした。
  
<a href="http://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/gettingstartedguide/GettingStarted.NodeJs.03.html" target="_blank">Step 3: Create, Read, Update, and Delete an Item &#8211; Amazon DynamoDB</a>
