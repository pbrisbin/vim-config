compiler ghc

setlocal omnifunc=necoghc#omnifunc
setlocal path+=lib,config
setlocal shiftwidth=4
setlocal tags=tags
setlocal wildignore+=*.hi,*.o,dist/**,tmp/**

let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'

map <Leader>g :! ghci %<cr>

autocmd BufWritePost *.hs GhcModCheckAndLintAsync
