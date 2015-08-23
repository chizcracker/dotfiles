set nocompatible
filetype off    " Required

set rtp+=~/.vim/bundle/Vundle.vim

" ------ plugin ------
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'ervandew/supertab'

" ruby
Plugin 'thoughtbot/vim-rspec'

" NodeJS
Plugin 'geekjuice/vim-mocha'

" clojure
Plugin 'vim-scripts/VimClojure'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-leiningen'
Plugin 'tpope/vim-projectionist'

call vundle#end()
" ------ plugin ------
filetype plugin indent on " Required

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
"set term=xterm-color
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
set clipboard=unnamed

" temp file dirs
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Trim Whitespace
map <Leader>w :StripWhitespace<CR>

" Unhighlight Search
map <Leader>/ :noh<CR>

" Python
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Ruby
map <Leader>rdb orequire 'ruby-debug'; debugger<ESC>
map <Leader>pry orequire 'pry'; binding.pry<ESC>

" ThoughtBot based test runner bindings (vim-rspec, vim-mocha)
map <Leader>rf :call RunCurrentSpecFile()<CR>
map <Leader>rl :call RunNearestSpec()<CR>
map <Leader>rr :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

" Tags
set tags+=.tags
set tags+=.gemtags

" SuperTab
" let g:SuperTabMappingForward = '<c-space>' "(default value: '<tab>')
" let g:SuperTabMappingBackward = '<s-c-space>' "(default value: '<s-tab>')
" let g:SuperTabMappingTabLiteral = "(default value: '<c-tab>')

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
    if part[0] =~ '\v[%#<]'
      let expanded_part = fnameescape(expand(part))
      let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
    endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction
