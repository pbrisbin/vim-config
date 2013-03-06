compiler ruby

setlocal wildignore+=*/coverage/*,*/doc/*,*/pkg/*

map <Leader>e :%! xmpfilter<cr>

if isdirectory('app')
  " probably rails
  let b:ctags_command = 'ctags -R app lib vendor'
elseif isdirectory('lib')
  " normal ruby project
  let b:ctags_command = 'ctags -R lib'
endif
