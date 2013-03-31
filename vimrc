" ~/.vimrc pbrisbin 2013

silent! execute pathogen#infect()

set nocompatible

set autoindent
set autowrite
set colorcolumn=80
set cursorline
set expandtab
set foldmethod=marker
set formatoptions-=t
set history=100
set hlsearch
set incsearch
set laststatus=2
set list listchars=tab:»·,trail:·
set nobackup
set nowrap
set number
set ruler
set scrolloff=999
set shiftwidth=2
set showmatch
set smartindent
set smarttab
set textwidth=72
set visualbell t_vb=
set wildignore+=*/.git/*
set wildmenu
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" fails on OSX's vim
silent! set formatoptions+=j

let mapleader = ','
let maplocalleader = ','

syntax on
filetype plugin indent on

let g:zenburn_old_Visual       = 1
let g:zenburn_alternate_Visual = 1
let g:zenburn_high_Contrast    = 1
colorscheme zenburn

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

inoremap {<CR> {<CR>}<C-o>O
inoremap [<CR> [<CR>]<C-o>O
inoremap (<CR> (<CR>)<C-o>O

nnoremap <C-l> :<C-u>nohlsearch<CR><C-l>

map <Leader>c <plug>NERDCommenterToggle
map <Leader>r :Run<CR>
map <Leader>m :make<CR>

cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

augroup vimrcEx
  autocmd!
  autocmd BufReadPost * call RestoreCursor()
  autocmd BufWritePre * call Mkdir()
augroup END

command! -range=% Sprunge :<line1>,<line2>write !curl -sF "sprunge=<-" http://sprunge.us

function! RestoreCursor()
  if line("'\"") > 0 && line("'\"") <= line("$")
    exe "normal g`\""
  endif
endfunction

function! Mkdir()
  let dir = expand('%:p:h')

  if !isdirectory(dir)
    call mkdir(dir, "p")
    echo "created non-existing directory: " . dir
  endif
endfunction

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
