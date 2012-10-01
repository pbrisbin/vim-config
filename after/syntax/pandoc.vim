" store old syntax value
let old_syntax = b:current_syntax
unlet b:current_syntax

syn include @hs  syntax/haskell.vim | unlet b:current_syntax
syn include @rb  syntax/ruby.vim    | unlet b:current_syntax
syn include @yml syntax/yaml.vim    | unlet b:current_syntax
syn include @sh  syntax/sh.vim      | unlet b:current_syntax

syn region hsBlock  matchgroup=codeBlock start=/^\~\~\~ { \.haskell }$/ end=/^\~\~\~$/ contains=@hs
syn region rbBlock  matchgroup=codeBlock start=/^\~\~\~ { \.ruby }$/    end=/^\~\~\~$/ contains=@rb
syn region ymlBlock matchgroup=codeBlock start=/^\~\~\~ { \.yaml }$/    end=/^\~\~\~$/ contains=@yml
syn region shBlock  matchgroup=codeBlock start=/^\~\~\~ { \.bash }$/    end=/^\~\~\~$/ contains=@sh

hi def link codeBlock String

hi pandocStrong gui=none cterm=none
hi def link pandocStrong Function

" restore old syntax value
let b:current_syntax = old_syntax
