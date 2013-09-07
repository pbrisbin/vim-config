compiler ruby

map <Leader>e :%! xmpfilter<cr>

if isdirectory('app')
  let b:ctags_command = "ctags -f '%f' -R --exclude='*.js' --langmap='ruby:+.rake.builder.rjs' --languages=-javascript app lib vendor"
else
  " normal ruby project
  let b:ctags_command = "ctags -f '%f' -R lib"
endif
