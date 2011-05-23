"
" ~/.vimrc by pbrisbin 2010
"

" load all submodules via pathogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" options {{{
set nocompatible

" set 256 colors if we can
if $TERM =~ "-256color"
  set t_Co=256
  colorscheme zenburn 
endif

" set the window title in screen
if $STY != ""
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
if has("multi_byte")
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
set tags=tags
set title
set textwidth=72
set visualbell t_vb=
set wildmode=longest,full

" syntax highlighting
syntax on
filetype plugin indent on

" local leader commands
let maplocalleader = ','

" haskellmode-vim needs these set as early as possible
let g:haddock_browser      = $BROWSER
let g:haddock_indexfiledir = "/home/patrick/.vim/"
let b:ghc_staticoptions    = '-ilib'

" supertab
let g:SuperTabLongestHighlight = 1
let g:SuperTabLongestEnhanced  = 1
let g:SuperTabDefaultCompletionType = 'context'

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

" escape is too far
inoremap jj <Esc>

" a transpose key
nmap <LocalLeader>t xp

"make
nnoremap <LocalLeader>k :make<CR>

" quickfix
nmap <LocalLeader>n :cn<CR>
nmap <LocalLeader>p :cp<CR>

" save the current file as root
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" }}}

" autocommands {{{
if has('autocmd')
  " vim itself
  au FileType vim let g:StartComment = "\""

  au BufWritePost ~/.vimrc     source %
  au BufWritePost ~/.vim/vimrc source %

  " reload Xdefaults when written
  au BufWritePost ~/.Xdefaults !xrdb ~/.Xdefaults

  " always do these
  au BufRead     * call SetStatusLine()
  au BufReadPost * call RestoreCursorPos()
  au BufWinEnter * call OpenFoldOnRestore()

  au BufEnter * let &titlestring = "vim: " . substitute(expand("%:p"), $HOME, "~", '')
  au BufEnter * let &titleold    = substitute(getcwd(), $HOME, "~", '')

  " file types for nonstandard/additional config files
  au BufEnter ~/.mutt/*      setlocal filetype=muttrc
  au BufEnter ~/.mutt/temp/* setlocal filetype=mail
  au BufEnter ~/.xcolors/*   setlocal filetype=xdefaults
  au BufEnter ~/.conky/*     setlocal filetype=conkyrc
  au BufEnter *.hamlet       setlocal filetype=hamlet
  au BufEnter *.cassius      setlocal filetype=cassius
  au BufEnter *.julius       setlocal filetype=julius
  au BufEnter *.rem          setlocal filetype=remind
  au BufEnter *.pdc          setlocal filetype=pdc
  au BufEnter *.md           setlocal filetype=pdc

  if $SCREEN_CONF_DIR != ""
    au BufEnter $SCREEN_CONF_DIR/* setlocal filetype=screen
  endif
endif

" }}}

" functions/commands {{{ 
function! SetStatusLine()
  let l:s1="%3.3n\\ %f\\ %h%m%r%w"
  let l:s2="[%{strlen(&filetype)?&filetype:'?'},\\ %{&encoding},\\ %{&fileformat}]"
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
