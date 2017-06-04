#!/bin/bash

BLOG_SOURCE_DIR=/Users/ei/GitHub/eikatou.net
WWW_DIR=/Users/ei/www
WWW_PUBLIC=${WWW_DIR}/eikatou.net

# hugo build
cd ${BLOG_SOURCE_DIR}
rm -rf ./public/*
hugo --theme=beautifulhugo

# backup
echo "Backup"
cd ${WWW_DIR}
mv ${WWW_PUBLIC}/blog ${WWW_DIR}/blog_`date +%Y%m%d_%I%M%S`

# 4世代以上前を削除（3世代を残す）
ls -dt blog* | tail +4 | xargs rm -rf

# copy
echo "Copy blog"
cp -r ${BLOG_SOURCE_DIR}/public ${WWW_PUBLIC}/blog

# feed
mkdir ${WWW_PUBLIC}/blog/feed
cp ${WWW_PUBLIC}/blog/index.xml ${WWW_PUBLIC}/blog/feed/index.html

# google page
cp ${WWW_DIR}/google8f78f6eb936c1d12.html ${WWW_PUBLIC}/blog

# s3 sync
echo "s3 sync"
aws s3 rm s3://eikatou.net/blog/index.html
aws s3 rm s3://eikatou.net/blog/index.xml
aws s3 rm s3://eikatou.net/blog/archives/index.html
aws s3 rm s3://eikatou.net/blog/archives/index.xml
aws s3 rm s3://eikatou.net/blog/tags/index.html
aws s3 rm s3://eikatou.net/blog/tags/index.xml
aws s3 sync --size-only --delete ${WWW_PUBLIC} s3://eikatou.net --exclude *.tmp --exclude .DS_Store
aws s3 ls s3://eikatou.net
