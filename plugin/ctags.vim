function! Ctags()
  if exists('b:tags_command')
    let tags_command = b:tags_command
  elseif exists('g:tags_command')
    let tags_command = g:tags_command
  else
    let tags_command = 'ctags -R'
  endif

  " assumes default location of ./tags
  let cmd = ':silent !rm -f tags; '.tags_command.' 2>/dev/null &'

  try
    execute cmd
  catch
    " ignore
  endtry
endfunction

" Allow us to call on demand
command! Ctags call Ctags()

" And automatically run it on open
autocmd BufEnter * call Ctags()
