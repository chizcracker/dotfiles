#!/bin/bash

# install pathogen first
# mkdir -p ~/.vim/autoload ~/.vim/bundle && \
# curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

TDIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
PP=$HOME'/.vim/bundle'
mkdir -p $PP

trap "{ cd - ; rm -rf $TDIR; exit 255; }" SIGINT

cd $TDIR

# vim setting
# color
git clone https://github.com/altercation/vim-colors-solarized.git

# plugin
git clone https://github.com/scrooloose/nerdtree.git
git clone git://github.com/ntpeters/vim-better-whitespace.git
git clone https://github.com/mileszs/ack.vim.git
git clone https://github.com/wesQ3/vim-windowswap.git

# clojure
git clone git://github.com/vim-scripts/VimClojure.git
git clone git://github.com/tpope/vim-dispatch.git
git clone git://github.com/tpope/vim-fireplace.git
git clone git://github.com/tpope/vim-leiningen.git
git clone git://github.com/tpope/vim-projectionist.git

mv * $PP
cd -

rm -rf $TDIR
exit 0
