setlocal omnifunc=necoghc#omnifunc
setlocal path+=app,config,templates
setlocal shiftwidth=4
setlocal wildignore+=*.hi,*.o,*/dist/*

map <Leader>g :! ghci %<cr>

if glob('*.cabal') != ''
  " in a haskell project, try to run ctags for main or Main which
  " should be entry to the entire project.
  if filereadable('app/main.hs')
    let b:ctags_command = 'echo ":ctags" | ghci -v0 app/main.hs'
  elseif filereadable('Main.hs')
    let b:ctags_command = 'echo ":ctags" | ghci -v0 Main.hs'
  endif
endif
