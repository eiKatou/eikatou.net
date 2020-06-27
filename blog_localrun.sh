#!/bin/bash

BLOG_SOURCE_DIR=/Users/ei/Documents/GitHub/eikatou.net

# hugo build
cd ${BLOG_SOURCE_DIR}
rm -rf themes/beautifulhugo
curl -L https://github.com/eiKatou/beautifulhugo/archive/master.zip -o themes/beautifulhugo.zip
unzip themes/beautifulhugo.zip -d themes/
mv themes/beautifulhugo-master themes/beautifulhugo
hugo server --theme=beautifulhugo
