if exists("g:sprunge_loaded")
  finish
endif

command -range=% Sprunge :<line1>,<line2>write !curl -sF "sprunge=<-" http://sprunge.us

let g:sprunge_loaded = 1
