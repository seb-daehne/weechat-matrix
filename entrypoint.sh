#!/bin/sh

if [ ! -e ~/.weechat/python/matrix.py ]; then
  echo "- file python/matrix.py does not exist - copy from template"
  cp ~/weechat-matrix/main.py ~/.weechat/python/matrix.py
fi

if [ ! -e ~/.weechat/python/matrix ]; then
  echo "- directory python/matrix does not exist - copy from template"
  cp -R ~/weechat-matrix/matrix ~/.weechat/python/matrix
fi

TERM=screen-256color weechat
