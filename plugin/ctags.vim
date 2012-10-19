function! Ctags()
  if exists('b:tags_command')
    let tags_command = b:tags_command
  elseif exists('g:tags_command')
    let tags_command = g:tags_command
  endif

  " this must be a no-op if we've not configured the command, this
  " prevents orphan tags files when we open up some rando file.
  "
  " to take advantage, when you set up that ctags command, also add some
  " conditions to confirm you're in a real project directory.
  "
  if exists('tags_command')
    " TODO: assumes default location of ./tags
    let cmd = ':silent !rm -f tags; '.tags_command.' 2>/dev/null &'

    try
      execute cmd
    catch
      " ignore any errors
    endtry
  end
endfunction

command! Ctags call Ctags()
autocmd BufEnter * call Ctags()
