setlocal shiftwidth=4
setlocal foldmethod=indent

let java_highlight_all       = 1
let java_highlight_functions = "style"
let java_allow_cpp_keywords  = 1

" eclim
let g:EclimBrowser          = '$BROWSER'
let g:EclimHome             = '/usr/share/vim/vimfiles/eclim'
let g:EclimEclipseHome      = '/usr/share/eclipse'
let g:EclimShowCurrentError = 0
let g:EclimPhpValidate      = 0
let g:EclimXmlValidate      = 0

nnoremap <silent> <LocalLeader>i :JavaImport<CR>
nnoremap <silent> <LocalLeader>d :JavaDocSearch -x declarations<CR>
nnoremap <silent> <LocalLeader><CR> :JavaSearchContext<CR>
nnoremap <silent> <LocalLeader>jv :Validate<CR>
nnoremap <silent> <LocalLeader>jc :JavaCorrect<CR>
