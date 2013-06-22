" ~/.vimrc pbrisbin 2013

silent! execute pathogen#infect()
silent! execute pathogen#helptags()

set nocompatible

set autoindent
set autoread
set autowrite
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

let g:ctags_excludes = [
  \ '~/.bin/',
  \ '~/.dotfiles/',
  \ '~/.dotfiles/.vim/',
  \ '~/.dotfiles/.zsh/',
  \ '~/.xmonad/',
  \ ]

inoremap {<CR> {<CR>}<C-o>O
inoremap [<CR> [<CR>]<C-o>O
inoremap (<CR> (<CR>)<C-o>O

nnoremap <C-l> :<C-u>nohlsearch<CR><C-l>

map <Leader>m :make<CR>
map <Leader>n :RenameFile<CR>
map <Leader>r :Run<CR>

cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

command! -range=% Sprunge :<line1>,<line2>write !curl -sF "sprunge=<-" http://sprunge.us

let &colorcolumn = join(range(81,999),",")

highlight ColorColumn ctermbg=235
