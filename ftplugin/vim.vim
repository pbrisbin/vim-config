" ignore bundles in command-t
setlocal wildignore+=*/bundle/*

" re-source on changes
au BufWritePost */.vimrc source %
au BufWritePost *vimrc   source %
