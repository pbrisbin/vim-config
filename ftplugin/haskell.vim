compiler ghc

setlocal omnifunc=necoghc#omnifunc
setlocal path+=lib,config
setlocal shiftwidth=4
setlocal tags=tags
setlocal wildignore+=*.hi,*.o,dist/**,tmp/**

map <Leader>g :! ghci %<cr>

autocmd BufWritePost *.hs GhcModCheckAndLintAsync
