source ~/.vim/autofix.vim

setlocal formatoptions+=twn
setlocal nohlsearch
setlocal shiftwidth=4
setlocal spell

" reformat paragraphs
nmap <F1> gqap
nmap <F2> gqqj
nmap <F3> kgqj
map! <F1> <ESC>gqapi
map! <F2> <ESC>gqqji
map! <F3> <ESC>kgqji

command! PDF :! (file="%"; markdown2pdf -o "${file\%.*}.pdf" "$file" &>/dev/null) &

if $DISPLAY != ""
  command! Open :! webpreview --open %
  command! Reload :! webpreview --reload %

  au BufWritePost /srv/http/pandoc/* silent Reload
endif
