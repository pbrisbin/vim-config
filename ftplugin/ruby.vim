let ruby_operators = 1
let g:SuperTabContextDefaultCompletionType = '<c-x><c-i>'

map <Leader>r :w<cr>:! ruby -Ilib %<cr>
map <Leader>tt :w<cr>:! ./bin/adhoc/vagrant-test %<cr>
