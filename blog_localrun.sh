#!/bin/bash

BLOG_SOURCE_DIR=/Users/ei/Documents/GitHub/eikatou.net

# hugo build
cd ${BLOG_SOURCE_DIR}
rm -rf themes/blog_theme
curl -L https://github.com/eiKatou/blog_theme/archive/main.zip -o themes/blog_theme.zip
unzip themes/blog_theme.zip -d themes/
mv themes/blog_theme-main themes/blog_theme
hugo server --theme=blog_theme
