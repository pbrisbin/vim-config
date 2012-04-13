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
set wildignore+=*/.git/*
set wildmode=longest,full

" syntax highlighting
syntax on
filetype plugin indent on

" colorscheme
let g:zenburn_old_Visual       = 1
let g:zenburn_alternate_Visual = 1
let g:zenburn_high_Contrast    = 1
colorscheme zenburn

" leader commands
let mapleader = ','
let maplocalleader = ','

" sessions
let g:session_autosave = 1
let g:session_autoload = 1

" haskellmode-vim needs these set as early as possible
let g:haddock_browser      = $BROWSER
let g:haddock_indexfiledir = $HOME . '/.vim/'

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

" gist-vim
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1

if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    let g:gist_clip_command = 'pbcopy'
  else
    let g:gist_clip_command = 'xclip'
  endif
endif

" ultisnips
let g:UltiSnipsEditSplit           = 'vertical'
let g:UltiSnipsSnippetsDir         = '~/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories  = ['UltiSnips', 'ultisnips']
let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

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

" rson's delimitmate
inoremap {<CR> {<CR>}<C-o>O
inoremap [<CR> [<CR>]<C-o>O
inoremap (<CR> (<CR>)<C-o>O

" comments
map <Leader>c <plug>NERDCommenterToggle

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
command! -range=% Sprunge :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us | read -r url; $BROWSER $url &>/dev/null; echo $url

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

" }}}
