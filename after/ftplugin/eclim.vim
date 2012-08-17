" we disable eclim by default everywhere. it's reenabled for java files
" only in after/plugin/java.vim
if exists("g:EclimHome")
  EclimDisable
endif
