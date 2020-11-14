---
title: "aws-cli,sam-cliコマンドをdockerコンテナで実行する"
date: 2020-10-25T07:30:00+09:00
author: eiKatou
type: post
url: /20201025.html
archives:
  - 2020
tags:
  - AWS 
---

aws-cli, sam-cliをdockerコンテナで実行できる。

aws-cliとかsam-cliをローカルPCに入れると、ローカルPCの環境が汚れてしまうのが気になっていた。普段Pythonは使わないので。。その他にaws-cliのバージョンアップをすると、Pythonのバージョンに問題が出て1時間ぐらいかかっていた。dockerを使うことで、これらの課題を解決する。

<!--more-->

# AWS CLI
[公式 AWS CLI バージョン 2 Docker イメージの使用 - AWS Command Line Interface](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/install-cliv2-docker.html)  
[amazon/aws-cli - Docker Hub](https://hub.docker.com/r/amazon/aws-cli)

使い方は公式ページの通り。~/.zshrcに以下を追記した。

```sh
# AWS
alias aws-docker='docker run --rm -ti -v ~/.aws:/root/.aws -v $(pwd):/aws -e AWS_PROFILE="$AWS_PROFILE" amazon/aws-cli'
```

s3バケットをの一覧を取得する。awsコマンドを”aws-docker”に置き換えるイメージ。
```sh
export AWS_PROFILE="hoge"
aws-docker s3 ls
```


# SAM CLI
[Docker コンテナで SAM CLI を使用する - Qiita](https://qiita.com/yh1224/items/80a652562291cf37c718)を参考にした。ありがたい記事。


sam-cliのDockerfileを作った。aws-cliのDockerイメージに合わせてWORKDIR変更やENTRYPOINT追加を行った。  
https://github.com/eiKatou/dotfiles/blob/master/Dockerfile/Dockerfile_awssam

Dockerイメージをビルド。
```sh
docker build -f Dockerfile_awssam -t aws-sam .
```

~/.zshrcに以下のaliasを追加。
```sh
# AWS
alias sam-docker='docker run --rm -ti -v ~/.aws:/root/.aws -v $(pwd):/aws -e AWS_PROFILE="$AWS_PROFILE" aws-sam'
```

template.yamlのあるディレクトリで以下を実行。
```sh
export AWS_PROFILE="hoge"
sam-docker validate -t template.yaml
```

今回追記したzshrcは以下に置いている。  
https://github.com/eiKatou/dotfiles/blob/master/zsh/zshrc