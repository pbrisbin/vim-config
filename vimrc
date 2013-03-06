"
" ~/.vimrc
"
" pbrisbin 2010, 2011, 2012
"

" load all submodules via pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" ensure vim-only settings work as intended
set nocompatible

" Main Options {{{
set autoindent
set autowrite
set backspace=indent,eol,start
set colorcolumn=80
set completeopt=menuone,preview
set cursorline
set expandtab
set foldmethod=marker
set formatoptions-=t
set history=50
set hlsearch
set incsearch
set laststatus=2
set list
set list listchars=tab:»·,trail:·
set mouse=v
set nobackup
set nowrap
set number
set ruler
set scrolloff=999
set shell=bash " zsh doesn't work with rvm
set shiftwidth=2
set sm
set smartindent
set smarttab
set textwidth=72
set visualbell t_vb=
set wildignore+=*/.git/*
set wildmenu
set wildmode=longest,full
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

try
  set formatoptions+=j
catch
  " ignore on versions where this doesn't work.
endtry

let mapleader = ','
let maplocalleader = ','
" }}}

" syntax highlighting / color scheme {{{
syntax on
filetype plugin indent on

let g:zenburn_old_Visual       = 1
let g:zenburn_alternate_Visual = 1
let g:zenburn_high_Contrast    = 1
colorscheme zenburn
" }}}

" plugin configuration {{{
let g:haddock_browser      = $BROWSER
let g:haddock_indexfiledir = $HOME . '/.vim/'

let g:ctrlp_clear_cache_on_exit = 0

let g:NERDCreateDefaultMappings    = 0
let g:NERDCommentWholeLinesInVMode = 1
let g:NERDCustomDelimiters = {
    \ 'haskell': { 'left': '--'    , 'right': ''     },
    \ 'hamlet' : { 'left': '\<!-- ', 'right': ' -->' },
    \ 'cassius': { 'left': '/* '   , 'right': ' */'  },
    \ 'lucius' : { 'left': '/* '   , 'right': ' */'  },
    \ 'julius' : { 'left': '//'    , 'right': ''     }
    \ }

let g:syntastic_mode_map = {
      \ 'mode': 'passive',
      \ 'active_filetypes': ['ruby']
      \ }

let g:pandoc_use_hard_wraps = 1
let g:pandoc_no_folding     = 1

let g:runfile_by_name = {
  \ '.*.feature': '!bundle exec cucumber %'
  \ }
" }}}

" keymaps {{{
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

inoremap {<cr> {<cr>}<C-o>O
inoremap [<cr> [<cr>]<C-o>O
inoremap (<cr> (<cr>)<C-o>O

nnoremap <cr> :nohlsearch<cr>

map <Leader>c <plug>NERDCommenterToggle
map <Leader>r :Run<cr>
map <Leader>m :make<cr>

cmap w!! w !sudo tee % >/dev/null<cr>:e!<cr><cr>
" }}}

" autocommands {{{
augroup vimrcEx
  autocmd!

  autocmd BufRead  * call SetStatusLine()
  autocmd BufWritePre * call Mkdir()

  " Restore cursor position when reopening a file
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " when an omnicompletion opens up a preview window (eclim) the following
  " will close the window on cursor movement or insert-exit
  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
  autocmd InsertLeave  * if pumvisible() == 0|pclose|endif
augroup END
" }}}

" functions/commands {{{ 
command! -range=% Sprunge :<line1>,<line2>write !curl -sF "sprunge=<-" http://sprunge.us

" Called when opening every file. If the containing directory doesn't
" exist, create it.
function! Mkdir()
  let dir = expand('%:p:h')

  if !isdirectory(dir)
    call mkdir(dir, "p")
    echo "created non-existing directory: " . dir
  endif
endfunction

function! SetStatusLine()
  let l:s1="%3.3n\\ %f\\ %h%m%r%w"
  let l:s2="[%{strlen(&filetype)?&filetype:'?'},\\ %{&encoding},\\ %{&fileformat}]\\ %{fugitive#statusline()}"
  let l:s3="%=\\ 0x%-8B\\ \\ %-14.(%l,%c%V%)\\ %<%P"
  execute "set statusline=" . l:s1 . l:s2 . l:s3
endfunction

" Simple supertab replacement
function! InsertTab()
  let col = col('.') - 1

  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-n>"
  endif
endfunction

inoremap <tab> <c-r>=InsertTab()<cr>
inoremap <s-tab> <c-p>

" Rename the current file and update the buffer. Based on
" https://github.com/km2r/vim-currentfile
function! Rename(dest)
  if &modified
    echoe "buffer is modified"
    return
  endif

  if len(glob(a:dest))
    echoe "destination already exists"
    return
  endif

  let filename = expand("%:p")
  let parent   = fnamemodify(a:dest, ":p:h")

  if !isdirectory(parent)
    call mkdir(parent, "p")
  endif

  exec "saveas " . a:dest
  call delete(filename)
endfunction
command! -nargs=1 -complete=file Rename call Rename(<f-args>)
" }}}
