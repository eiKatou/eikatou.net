---
title: Docker上のWordPressデータのバックアップ＆リストア
author: eiKatou
type: post
date: 2017-05-01T02:42:45+00:00
url: /3350.html
archives:
  - 2017
tags:
  - Web

---
<img src="./uploads/2017/04/docker_logo.png" alt="" width="600" height="206" class="alignnone size-full wp-image-3338" srcset="./uploads/2017/04/docker_logo.png 600w, ./uploads/2017/04/docker_logo-300x103.png 300w, ./uploads/2017/04/docker_logo-500x172.png 500w" sizes="(max-width: 600px) 100vw, 600px" />前回、<a href="/3299.html" target="_blank">DockerでWordPress環境を構築</a>した。Dockerは現在も開発が続いており、やや不安定なソフトウェアという印象がある。そういう事情もあり、Docker内のWordPress環境のデータをバックアップ＆リストアできるようにしておく。

・参考：<a href="https://docs.docker.com/engine/tutorials/dockervolumes/" target="_blank">Manage data in containers</a> 

<!--more-->

# Volumeの内容を見る

## Volumeの確認

まずはVolumeが存在することを確認する。

<div class="code_box">
  $ docker volume ls<br /> DRIVER VOLUME NAME<br /> local wordpress_db_data<br /> local wordpress_phpmyadmin_data<br /> local wordpress_www_data
</div></p> 

ここでは、3つのVolumeがあることが確認できた。
  
今回バックアップを行いたいのは、以下の2つである。
  
・wordpress\_www\_data
  
・wordpress\_db\_data 

## Volumeの内容を見る

Volumeの内容を見るためにコンテナを作成する必要がある。以下のコマンドで、Volumeをマウントした状態のコンテナを起動する。

<div class="code_box">
  $ docker run -it &#8211;name wp_www_dc -v wordpress_www_data:/www_data ubuntu /bin/bash</p> 
  
  <p>
    root@6765f5b2c015:/# ls<br /> bin dev home lib64 mnt proc run srv tmp var<br /> boot etc lib media opt root sbin sys usr www_data
  </p>
  
  <p>
    $ docker run -it &#8211;name wp_db_dc -v wordpress_db_data:/db_data ubuntu /bin/bash
  </p>
  
  <p>
    root@c7496a7fa129:/# ls<br /> bin db_data etc lib media opt root sbin sys usr<br /> boot dev home lib64 mnt proc run srv tmp var
  </p>
</div></p> 

docker runコマンドでコンテナを作成する。-itオプションは起動しっぱなしにできるオプション。&#8211;nameオプションでコンテナに名前をつける。-vオプションで、Volumeを特定のパスにマウントする。

Volume「wordpress\_www\_data」は、/www\_dataにマウントされて起動される。1つ目のdocker runコマンドの後のlsコマンドで、www\_dataが確認できる。 

## Volumeの内容を見る（次回から）

先ほどのコマンドでコンテナができたので、次回からは以下のコマンドでコンテナを起動すれば良い。

<div class="code_box">
  $ docker ps -a</p> 
  
  <p>
    CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES<br /> c7496a7fa129 ubuntu &#8220;/bin/bash&#8221; 14 minutes ago Exited (0) 13 minutes ago wp_db_dc<br /> 6765f5b2c015 ubuntu &#8220;/bin/bash&#8221; 12 days ago Exited (0) 7 minutes ago wp_www_dc
  </p>
  
  <p>
    $ docker start -i wp_www_dc
  </p>
  
  <p>
    $ docker start -i wp_db_dc
  </p>
</div></p> 

# Volumeのデータをバックアップ

Volumeのデータをバックアップする。べたな方法であるが、現在のローカルPCのディレクトリを/backupにマウントして、バックアップしたいディレクトをtarで固めて/backupに出力するだけである。

<div class="code_box">
  $ docker run &#8211;rm &#8211;volumes-from wp_www_dc -v $(pwd):/backup ubuntu tar cvf /backup/backup_www.tar /www_data</p> 
  
  <p>
    $ docker run &#8211;rm &#8211;volumes-from wp_db_dc -v $(pwd):/backup ubuntu tar cvf /backup/backup_db.tar /db_data
  </p>
</div></p> 

MySQLのデータは、phpMyAdminからデータのエクスポートを行うのも良いだろう。 

# Volumeのデータをリストア

Volumeのデータをリストアするときも同じで、コンテナを作成し、先ほどのtarファイルを展開して配置するだけ。

<div class="code_box">
  $ docker run -it &#8211;name wp_www_dc2 -v wordpress_www_data:/www_data ubuntu /bin/bash</p> 
  
  <p>
    $ docker start -i wp_www_dc2
  </p>
  
  <p>
    $ docker run &#8211;rm &#8211;volumes-from wp_www_dc2 -v $(pwd):/backup ubuntu bash -c &#8220;cd /www_data && tar xvf /backup/backup_www.tar &#8211;strip 1&#8221;
  </p>
</div></p> 

# まとめ

今後、主流となっていくであろう2つの技術（AWSとDocker）を利用して、WordPressのブログを安く維持できる仕組みを構築した。今後、AWSはさらに便利に安くなっていくだろうし、勉強する価値がある。また、Dockerの動向も目が離せない。
  
・<a href="/3247.html" target="_blank">WordPressのブログをAWS S3で公開する</a>
  
・<a href="/3299.html" target="_blank">DockerでWordPress環境を構築する</a>
  
・<a href="/3350.html" target="_blank">Docker上のWordPressデータのバックアップ＆リストア</a>
