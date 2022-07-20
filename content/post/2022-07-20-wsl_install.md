---
title: "WSL2のインストール"
date: 2022-07-20T14:45:54+09:00
author: eiKatou
type: post
url: /20220720.html
archives:
  - 2022
tags:
  - Windows
  - Linux
---

Windows 11にWSL2をインストールした記録。

<!--more-->

# 公式サイト
[WSL のインストール | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/wsl/install)

# WSL2のインストール
コントロールパネル > プログラムを開く。

Windowsの機能の有効化または無効化を開く。
![wsl](/uploads/2022/07/wsl1.png)

Linux用Windowsサブシステムにチェックを入れる。
![wsl](/uploads/2022/07/wsl2.png)

Microsoft StoreからUbuntuをインストール。
![wsl](/uploads/2022/07/wsl3.png)

アプリとしてUbuntuがインストールされているので起動。

## error: 0x800701bc
起動すると以下のエラーが表示された。
> WslRegisterDistribution failed with error: 0x800701bc

Kernelのアップデートが必要らしいので、管理者権限のコマンドプロンプトで以下のコマンドを実行する。
```bash
wsl --update
```

## error: 0x80370102
気を取り直して再度起動。
次は以下のエラーが表示された。

> WslRegisterDistribution failed with error: 0x80370102
> Please enable the Virtual Machine Platform Windows feature and ensure virtualization is enabled in the BIOS.
> For information please visit https://aka.ms/enablevirtualization

「仮想化マシンプラットフォーム」をクリックして有効化する。
![wsl](/uploads/2022/07/wsl4.png)

これで起動できるようになった。

## インストール完了
Ubuntuを起動してパッケージの更新をしておこう。
```bash
sudo apt-get update
sudo apt-get upgrade
```

最近はapt-getよりaptの方がいいみたい。  
[apt と apt-get の違い | rs-techdev](https://rs-techdev.com/archives/151)

# 最後に
Linuxという力強い味方が手に入るので、ぜひインストールしておこう。
