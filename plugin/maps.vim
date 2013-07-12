inoremap {<CR> {<CR>}<C-o>O
inoremap [<CR> [<CR>]<C-o>O
inoremap (<CR> (<CR>)<C-o>O
inoremap ({<CR> ({<CR>})<C-o>O
inoremap ([<CR> ([<CR>])<C-o>O

nnoremap <C-l> :<C-u>nohlsearch<CR><C-l>

cmap w!! w !sudo tee % >/dev/null<CR>
