let old_syntax = b:current_syntax
unlet b:current_syntax

syn include @hs  syntax/haskell.vim | unlet b:current_syntax
syn include @rb  syntax/ruby.vim    | unlet b:current_syntax
syn include @yml syntax/yaml.vim    | unlet b:current_syntax
syn include @sh  syntax/sh.vim      | unlet b:current_syntax

syn region markdownCode matchgroup=markdownCodeDelimiter start="\~\~\~ \=" end=" \=\~\~\~" keepend contains=markdownLineStart

syn region pdcHsBlock  matchgroup=markdownCodeDelimiter start=/^\~\~\~ { \.haskell }$/ end=/^\~\~\~$/ contains=@hs
syn region pdcRbBlock  matchgroup=markdownCodeDelimiter start=/^\~\~\~ { \.ruby }$/    end=/^\~\~\~$/ contains=@rb
syn region pdcYmlBlock matchgroup=markdownCodeDelimiter start=/^\~\~\~ { \.yaml }$/    end=/^\~\~\~$/ contains=@yml
syn region pdcShBlock  matchgroup=markdownCodeDelimiter start=/^\~\~\~ { \.bash }$/    end=/^\~\~\~$/ contains=@sh

let b:current_syntax = old_syntax
