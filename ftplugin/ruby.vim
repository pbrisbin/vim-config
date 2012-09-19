function! Ctags()
  if isdirectory('app')
    " probably rails
    execute ':silent !ctags -R app lib vendor 2>/dev/null &'
  elseif isdirectory('lib')
    " normal rails project
    execute ':silent !ctags -R lib 2>/dev/null &'
  endif
endfunction

command! Ctags call Ctags()

autocmd BufEnter * call Ctags()
