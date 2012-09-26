compiler ruby

setlocal wildignore+=*/coverage/*,*/doc/*,*/pkg/*

function! Ctags()
  if isdirectory('app')
    " probably rails
    execute ':silent !rm -f tags; ctags -R app lib 2>/dev/null &'
  elseif isdirectory('lib')
    " normal rails project
    execute ':silent !rm -f tags; ctags -R lib 2>/dev/null &'
  endif
endfunction

command! Ctags call Ctags()

autocmd BufEnter * call Ctags()
