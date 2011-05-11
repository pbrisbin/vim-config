setlocal autochdir
setlocal formatoptions+=w " for hamlet blocks
setlocal path+=lib
setlocal shiftwidth=4

let b:ghc_staticoptions = '-ilib'
let g:StartComment      = "--"
let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'

" set the compiler to hlint and make, then put it back to ghc
function! Hlint()
  compiler hlint
  make
  compiler ghc
endfunction

command! Hlint call Hlint()

command! Interpret :! ghci -ilib %
command! Run       :! runhaskell %
