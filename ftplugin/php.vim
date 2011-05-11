setlocal shiftwidth=4
let g:StartComment = "//"
let g:EndComment   = ""
command! CheckPHP :! php -l %
command! OpenPHP  :! php %
