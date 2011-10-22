"
" ~/.vimrc 
"
" pbrisbin 2010, 2011
"

" load all submodules via pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" options {{{
set nocompatible

" 256 colors if we can
if $TERM =~ "-256color"
  set t_Co=256
endif

" set the window title in screen
if $STY != "" && !has('gui')
  set t_ts=k
  set t_fs=\
endif

" use folding if we can
if has ('folding')
  set foldenable
  set foldmethod=marker
  set foldmarker={{{,}}}
  set foldcolumn=0
endif

" utf-8
if has('multi_byte')
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" main options
set autoindent
set autowrite
set background=dark
set backspace=indent,eol,start
set completeopt=menuone,preview
set cursorline
set expandtab
set formatoptions-=t
set guioptions=
set history=50
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set mouse=v
set nobackup
set nowrap
set number
set ruler
set scrolloff=999
set shiftwidth=2
set shortmess+=r
set sm
set smartcase
set smartindent
set smarttab
set splitbelow
set splitright
set tabstop=8
set tags=tmp/tags
set title
set textwidth=72
set visualbell t_vb=
set wildmode=longest,full

" syntax highlighting
syntax on
filetype plugin indent on

" colorscheme
let zenburn_old_Visual    = 1
let zenburn_high_Contrast = 1
colorscheme zenburn

" leader commands
let mapleader = ','
let maplocalleader = ','

" haskellmode-vim needs these set as early as possible
let g:haddock_browser      = $BROWSER
let g:haddock_indexfiledir = "/home/patrick/.vim/"

" supertab
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" commenter
let NERDCreateDefaultMappings    = 0
let NERDCommentWholeLinesInVMode = 1

let g:NERDCustomDelimiters = {
    \ 'haskell': { 'left': '--'    , 'right': ''     },
    \ 'hamlet' : { 'left': '\<!-- ', 'right': ' -->' },
    \ 'cassius': { 'left': '/* '   , 'right': ' */'  },
    \ 'lucius' : { 'left': '/* '   , 'right': ' */'  },
    \ 'julius' : { 'left': '//'    , 'right': ''     }
\ }

" }}}

" keymaps {{{
" annoying
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" window/buffer navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-n> :next<CR>
nnoremap <C-p> :prev<CR>

" rson's delimitmate
inoremap {<CR> {<CR>}<C-o>O
inoremap [<CR> [<CR>]<C-o>O
inoremap (<CR> (<CR>)<C-o>O

" comments
map <Leader>c <plug>NERDCommenterToggle

" command-t
nmap <silent> <Leader>F :CommandT<CR>

" save the current file as root
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" }}}

" autocommands {{{
au BufWritePost ~/.Xdefaults !xrdb ~/.Xdefaults

au BufRead     * call SetStatusLine()
au BufReadPost * call RestoreCursorPos()
au BufWinEnter * call OpenFoldOnRestore()

au BufEnter * let &titlestring = "vim: " . substitute(expand("%:p"), $HOME, "~", '')
au BufEnter * let &titleold    = substitute(getcwd(), $HOME, "~", '')

" }}}

" functions/commands {{{ 
command! -range=% Share :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us | pee cat xclip

function! SetStatusLine()
  let l:s1="%3.3n\\ %f\\ %h%m%r%w"
  let l:s2="[%{strlen(&filetype)?&filetype:'?'},\\ %{&encoding},\\ %{&fileformat}]\\ %{fugitive#statusline()}"
  let l:s3="%=\\ 0x%-8B\\ \\ %-14.(%l,%c%V%)\\ %<%P"
  execute "set statusline=" . l:s1 . l:s2 . l:s3
endfunction

function! RestoreCursorPos()
  if expand("<afile>:p:h") !=? $TEMP 
    if line("'\"") > 1 && line("'\"") <= line("$") 
      let line_num = line("'\"") 
      let b:doopenfold = 1 
      if (foldlevel(line_num) > foldlevel(line_num - 1)) 
        let line_num = line_num - 1 
        let b:doopenfold = 2 
      endif 
      execute line_num 
    endif 
  endif
endfunction

function! OpenFoldOnRestore()
  if exists("b:doopenfold") 
    execute "normal zv"
    if(b:doopenfold > 1)
      execute "+".1
    endif
    unlet b:doopenfold 
  endif
endfunction

function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction

command! -nargs=+ MapToggle call MapToggle(<f-args>)

MapToggle <F4> foldenable 
MapToggle <F5> number 
MapToggle <F6> spell 
MapToggle <F7> paste 
MapToggle <F8> hlsearch 
MapToggle <F9> wrap 

" }}}

