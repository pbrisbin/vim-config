compiler ghc

setlocal omnifunc=necoghc#omnifunc
setlocal path+=lib,config
setlocal shiftwidth=4
setlocal wildignore+=*.hi,*.o,dist/**,tmp/**

map <Leader>g :! ghci %<cr>

function! Ctags()
  if glob('*.cabal') != ''
    " in a haskell project, try to run ctags for main or Main which
    " should be entry to the entire project.
    if filereadable('main.hs')
      execute ':silent !echo ":ctags" | ghci -v0 main.hs 2>/dev/null &'
    elseif filereadable('Main.hs')
      execute ':silent !echo ":ctags" | ghci -v0 Main.hs 2>/dev/null &'
    endif
  endif
endfunction

command! Ctags call Ctags()

autocmd BufEnter     *    call Ctags()
autocmd BufWritePost *.hs GhcModCheckAndLintAsync
