compiler ruby

setlocal wildignore+=*/coverage/*,*/doc/*,*/pkg/*

map <Leader>e :%! xmpfilter<cr>
map <Leader>t :!bundle exec rspec -c -fd %<CR>
map <Leader>s :!bundle exec rspec -c -fd -l <C-R>= line('.')<CR> %<CR>

if isdirectory('app')
  " probably rails
  let b:ctags_command = 'ctags -R app lib vendor'
elseif isdirectory('lib')
  " normal ruby project
  let b:ctags_command = 'ctags -R lib'
endif
