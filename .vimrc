"Pathogen setting
execute pathogen#infect()
Helptags

syntax enable
filetype plugin indent on
let &t_Co=256

"VimClojure setting
let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1

"Run Midje tests
command Midje Eval (require 'midje.repl)(midje.repl/load-facts :all)

"NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"Vim setting
set nu
set ruler
set nocompatible
set background=dark
set mouse=a
colorscheme solarized
set backspace=indent,eol,start
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set laststatus=2
set encoding=utf-8
set whichwrap=h,l,[,]
set hlsearch

"Python setting
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
