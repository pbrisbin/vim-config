setlocal autochdir
setlocal formatoptions+=t
setlocal shiftwidth=4
setlocal spell

" execute the external command silently and redraw. conveniently, this
" pauses showing the output if the command returns non-zero.
command! -nargs=1 Silent
  \ | execute ':silent !'.<q-args>
  \ | execute ':redraw!'

" open the pdf version of this document in zathura. assumes it's already
" been processed and the pdf is present.
command! Open :Silent file="%"; zathura --fork "${file/.tex/.pdf}"

" reprocess the tex into pdf silently. will flash and return if
" succesful but pause and let you work with the errors if not.
command! Refresh :Silent pdflatex %

map <Leader>o :w<cr>:Open<cr>
map <Leader>R :w<cr>:Refresh<cr>
