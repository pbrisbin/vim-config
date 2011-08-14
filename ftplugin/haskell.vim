compiler ghc
setlocal path+=lib,config
setlocal shiftwidth=4
setlocal wildignore+=*.hi,*.o,dist/**

let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'

map <Leader>m :make<cr>
map <Leader>g :! ghci %<cr>
map <Leader>r :! runhaskell %<cr>
