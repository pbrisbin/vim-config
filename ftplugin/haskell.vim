compiler ghc

setlocal omnifunc=necoghc#omnifunc
setlocal path+=lib,config
setlocal shiftwidth=4
setlocal wildignore+=*.hi,*.o,*/dist/*

map <Leader>g :! ghci %<cr>

if glob('*.cabal') != ''
  " in a haskell project, try to run ctags for main or Main which
  " should be entry to the entire project.
  if filereadable('main.hs')
    let b:ctags_command = 'echo ":ctags" | ghci -v0 main.hs'
  elseif filereadable('Main.hs')
    let b:ctags_command = 'echo ":ctags" | ghci -v0 Main.hs'
  endif
endif

autocmd BufWritePost *.hs GhcModCheckAndLintAsync
