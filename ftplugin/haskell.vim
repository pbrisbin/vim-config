compiler ghc
setlocal formatoptions+=w " for hamlet blocks
setlocal path+=lib
setlocal shiftwidth=4
setlocal wildignore+=*.hi,*.o,dist/**

let g:SuperTabContextDefaultCompletionType = '<c-x><c-o>'

command! Interpret :! ghci -ilib %
command! Run       :! runhaskell %
