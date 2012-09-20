compiler tidy

setlocal shiftwidth=4

map <Leader>t :%!tidy -q -i -f /dev/null<cr>
