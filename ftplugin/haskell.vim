setlocal omnifunc=necoghc#omnifunc
setlocal path+=app,config,templates
setlocal shiftwidth=4

map <Leader>g :! ghci %<cr>

let b:ctags_command = 'hs-ctags %f'
