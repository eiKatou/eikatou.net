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

# copy
echo "Copy blog"
cp -r ${BLOG_SOURCE_DIR}/public ${WWW_PUBLIC}/blog

# google page
cp ${WWW_DIR}/google8f78f6eb936c1d12.html ${WWW_PUBLIC}/blog

# s3 sync
echo "s3 sync"
aws s3 sync --size-only --delete ${WWW_PUBLIC} s3://eikatou.net --exclude *.tmp --exclude .DS_Store
aws s3 ls s3://eikatou.net
