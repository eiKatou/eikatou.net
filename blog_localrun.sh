#!/bin/bash

BLOG_SOURCE_DIR=/Users/ei/Documents/GitHub/eikatou.net

# hugo build
cd ${BLOG_SOURCE_DIR}
rm -rf themes/eikatou.net_theme
curl -L https://github.com/eiKatou/eikatou.net_theme/archive/main.zip -o themes/eikatou.net_theme-main.zip
unzip themes/eikatou.net_theme-main.zip -d themes/
mv themes/eikatou.net_theme-main themes/eikatou.net_theme
hugo server --theme=eikatou.net_theme
