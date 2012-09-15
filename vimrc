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

" main options
set autoindent
set autowrite
set backspace=indent,eol,start
set completeopt=menuone,preview
set cursorline
set expandtab
set foldmethod=marker
set formatoptions-=t
set history=50
set incsearch
set laststatus=2
set list
set listchars=trail:·
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
set tags=tmp/tags
set title
set textwidth=72
set visualbell t_vb=
set wildignore+=*/.git/*
set wildmode=longest,full

try
  set formatoptions+=j
catch
  " ignore the error on machines without this option
endtry

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

" syntastic
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'passive_filetypes': ['haskell', 'html', 'tex']
      \ }

" vim-notes
let g:notes_directory = '~/Dropbox/notes'

" pandoc
let g:pandoc_use_hard_wraps = 1
let g:pandoc_auto_format = 1
let g:pandoc_no_folding = 1

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

" runfile
map <Leader>r :Run<cr>

" make
map <Leader>m :make<cr>

" save the current file as root
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" }}}

" autocommands {{{
au BufWritePost ~/.Xdefaults !xrdb ~/.Xdefaults

au BufRead     * call SetStatusLine()
au BufReadPost * call RestoreCursorPos()
au BufWinEnter * call OpenFoldOnRestore()
au BufEnter    * call Mkdir()

au BufEnter * let &titlestring = "vim: " . substitute(expand("%:p"), $HOME, "~", '')
au BufEnter * let &titleold    = substitute(getcwd(), $HOME, "~", '')

" when an omnicompletion opens up a preview window (eclim) the following
" will close the window on cursor movement or insert-exit
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" }}}

" functions/commands {{{ 
command! -range=% Sprunge :<line1>,<line2>write !curl -sF "sprunge=<-" http://sprunge.us

function! Mkdir()
  let dir = expand('%:p:h')

  if !isdirectory(dir)
    call mkdir(dir, "p")
    echo "created non-existing directory: " . dir
  endif
endfunction

" based on https://github.com/km2r/vim-currentfile
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
