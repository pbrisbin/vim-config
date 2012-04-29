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

nnoremap <silent> <leader>i :JavaImport<cr>
nnoremap <silent> <leader>d :JavaDocSearch -x declarations<cr>
nnoremap <silent> <leader><cr> :JavaSearchContext<cr>
nnoremap <silent> <leader>jv :Validate<cr>
nnoremap <silent> <leader>jc :JavaCorrect<cr>
