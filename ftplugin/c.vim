setlocal formatoptions+=ro
setlocal shiftwidth=4
syn match matchName /\(#define\)\@<= .*/
let g:StartComment = "//"
