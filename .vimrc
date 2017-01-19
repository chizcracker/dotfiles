set nocompatible

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'ervandew/supertab'

" ruby
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }

" NodeJS
Plug 'geekjuice/vim-mocha', { 'for': 'javascript' }

" clojure
Plug 'vim-scripts/VimClojure', { 'for': 'clojure' }
Plug 'tpope/vim-dispatch', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-projectionist', { 'for': 'clojure' }

" Initialize plugin system
call plug#end()

syntax enable
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

" tmp file directories
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
let g:rspec_runner = "os_x_iterm2"
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
