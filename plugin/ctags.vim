" Ctags
"
" pbrisbin 2012
"
" Removes b:ctags_file and runs b:ctags_command. Does nothing unless
" b:ctags_command has been actively defined. b:ctags_file defaults to
" tags.
"
" Be sure you only define a ctags command if you've done some check that
" you are actually in a project directory. Otherwise, you may end up
" with a runaway ctags process churning away at your home directory.
"
function! Ctags()
  if exists('b:ctags_command')
    " vim lets you define multiple tags files. this doesn't work for us.
    " we want to know an exact file so we can actively remove it.
    if !exists('b:ctags_file')
      let b:ctags_file = 'tags'
    endif

    try
      execute ':silent !rm -f '.b:ctags_file.'; '.b:ctags_command.' 2>/dev/null &'
    catch
      " ignore any errors
    endtry
  endif
endfunction

command! Ctags call Ctags()
autocmd BufEnter * call Ctags()
