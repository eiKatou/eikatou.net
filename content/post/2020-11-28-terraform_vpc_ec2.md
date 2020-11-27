---
title: "TerrafomでEC2を作る"
date: 2020-11-28T06:54:05+09:00
author: eiKatou
type: post
url: /20201128.html
archives:
  - 2020
tags:
  - IT技術
---

[Terraform by HashiCorp](https://www.terraform.io/)に入門した。後回しにし続けてきたのだけど、良いという話を聞いたので触ってみることにした。

<!--more-->
# 環境
```shell
$ terraform -version
Terraform v0.13.5

$ sw_vers
ProductName:    Mac OS X
ProductVersion: 10.14.6
BuildVersion:   18G4032
```

# Terraform入門
[Introduction - Terraform by HashiCorp](https://www.terraform.io/intro/index.html)を一通りやった。

Introductionを進める中で、一点だけ引っかかった。
```shell
$ terraform init
$ terraform fmt
$ terraform validate
$ terraform apply

Error: No valid credential sources found for AWS Provider.
        Please see https://terraform.io/docs/providers/aws/index.html for more information on
        providing credentials for the AWS Provider
```

以下のprofileの"default"が定義されていない。
```shell
provider "aws" {
  profile = "default"
  region  = "us-west-2"
}
```

profileの行を消すとAWS_PROFILEが使われる。再実行して問題なく動いた。

覚えるコマンドも少ないし、applyで変更点を示してくれるし、この時点でかなり良い雰囲気を感じた。

# VPC-subnect-EC2を作る
VPC周りのネットワーク関係を設定して、EC2を起動してSSHしたい。これは基本の流れかなと思っている。

以下のリソースを作り、EC2にSSHできるようにする。
- VPC 1つ
- public subnet 1つ
- その他ネットワーク関係(internet gateway, route table)
- subnet内にEC2 1つ
- EC2にはssh key pairを渡す
- EC2にはpublic DNSホスト名を付与する

初学者でも分かりやすいサイトを見つけて、参考にさせてもらった。
- [TerraformでVPC・EC2インスタンスを構築してssh接続する - Qiita](https://qiita.com/kou_pg_0131/items/45cdde3d27bd75f1bfd5)
- [hashicorp/aws | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest)
- [Terraformで自分のパブリックIPを使う方法 | Developers.IO](https://dev.classmethod.jp/articles/reference-my-pubic-ip-in-terraform/)

## 完成！！
ほとんど写経みたいになったが、動くものになった。  
[Sample/terraform/vpc_subnet at master · eiKatou/Sample](https://github.com/eiKatou/Sample/tree/master/terraform/vpc_subnet)

```shell
eimbp:vpc_subnet $ terraform apply
(省略..)
aws_instance.main_ec2: Creation complete after 29s [id=i-0ef99236fc8311f0a]

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

main_ec2_public_dns = ec2-54-186-36-40.us-west-2.compute.amazonaws.com

eimbp:vpc_subnet $ ssh -i ./ec2-key-pair ec2-user@ec2-54-186-36-40.us-west-2.compute.amazonaws.com


       __|  __|_  )
       _|  (     /   Amazon Linux 2 AMI
      ___|\___|___|

https://aws.amazon.com/amazon-linux-2/

```

# Terraformの感想
思った以上に良い。使いこなしたら神になれると思った。
![internet_god](/uploads/illustration/internet_god.png)
