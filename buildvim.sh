#!/bin/bash

CFG="--enable-cscope --enable-multibyte --enable-xim --enable-gtk2-check --with-features=big --enable-pythoninterp=yes"
PREFIX="--prefix=/usr/local"

mkdir 7.3
echo "
open ftp.vim.org
cd /pub/vim/unix
get -c vim-7.3.tar.bz2
cd /pub/vim/patches/7.3
lcd 7.3
mget -c 7.3*" | lftp

tar jxvf vim-7.3.tar.bz2
cd vim73
for p in ../7.3/7.3*; do 
echo Applying $p...
patch -p < $p;
done

./configure $PREFIX $CFG
make
if [ $? -eq 0 ]; then
    echo "Run make install to install into /usr/local/"
fi
