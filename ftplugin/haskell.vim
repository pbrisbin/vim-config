setlocal omnifunc=necoghc#omnifunc
setlocal path+=app,config,templates
setlocal shiftwidth=4
setlocal wildignore+=*.hi,*.o,*/dist/*

map <Leader>g :! ghci %<cr>

let b:ctags_command = 'hs-ctags %f'
