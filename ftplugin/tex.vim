setlocal autochdir
setlocal shiftwidth=4
setlocal spell

if $DISPLAY != ""
  command! Open   :! (file="%"; pdflatex "$file" $>/dev/null && zathura "${file/.tex/.pdf}" &>/dev/null) &
  command! Reload :! (pdflatex % &>/dev/null) &

  au BufWritePost *.tex silent Reload
endif
