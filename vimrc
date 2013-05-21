" ~/.vimrc pbrisbin 2013

silent! execute pathogen#infect()
silent! execute pathogen#helptags()

set nocompatible

set autoindent
set autowrite
set colorcolumn=80
set cursorline
set expandtab
set foldmethod=marker
set formatoptions-=t
set formatoptions+=j
set history=500
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
set wildignore+=*/.git/*,*/tmp/*
set wildmode=list:longest
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

let mapleader = ','
let maplocalleader = ','

syntax on
filetype plugin indent on

let g:ctrlp_clear_cache_on_exit = 0
let g:pandoc_no_folding         = 1
let g:pandoc_use_hard_wraps     = 1
let g:zenburn_alternate_Visual  = 1
let g:zenburn_high_Contrast     = 1
let g:zenburn_old_Visual        = 1
colorscheme zenburn

let g:syntastic_mode_map = {
  \ 'mode': 'passive',
  \ 'active_filetypes': ['ruby']
  \ }

inoremap {<CR> {<CR>}<C-o>O
inoremap [<CR> [<CR>]<C-o>O
inoremap (<CR> (<CR>)<C-o>O

nnoremap <C-l> :<C-u>nohlsearch<CR><C-l>

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

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', old_name, 'file')

  if new_name != '' && new_name != old_name
    exec 'saveas ' . new_name
    call delete(old_name)
  endif
endfunction
map <Leader>n :call RenameFile()<CR>
