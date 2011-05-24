compiler ghc
setlocal autochdir
setlocal formatoptions+=w " for hamlet blocks
setlocal path+=lib
setlocal shiftwidth=4

let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'

nmap <Leader>h :call Hlint()<CR>

" set the compiler to hlint and make, then put it back to ghc
function! Hlint()
  compiler hlint
  make
  compiler ghc
endfunction

command! Interpret :! ghci -ilib %
command! Run       :! runhaskell %
