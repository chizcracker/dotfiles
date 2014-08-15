#!/bin/bash

# install pathogen first
# mkdir -p ~/.vim/autoload ~/.vim/bundle && \
# curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

TDIR=`mktemp -d 2>/dev/null || mktemp -d -t 'mytmpdir'`
PP='/vimrc/bundle'

trap "{ cd - ; rm -rf $TDIR; exit 255; }" SIGINT

cd $TDIR
mkdir -p $HOME$PP
git clone git://github.com/vim-scripts/VimClojure.git
git clone https://github.com/scrooloose/nerdtree.git
git clone git://github.com/ntpeters/vim-better-whitespace.git
git clone https://github.com/altercation/vim-colors-solarized.git
git clone git://github.com/tpope/vim-dispatch.git
git clone git://github.com/tpope/vim-fireplace.git
git clone git://github.com/tpope/vim-leiningen.git
git clone git://github.com/tpope/vim-projectionist.git
mv * $HOME$PP
cd -

rm -rf $TDIR
exit 0
