" Tomorrow Night Burns for Neovim/Terminal Vim
set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "tomorrow-night-burns"

hi Normal       guifg=#a1b0b8 guibg=#151515 ctermfg=251 ctermbg=233
hi Cursor       guifg=#151515 guibg=#ff443e ctermfg=233 ctermbg=203
hi Visual       guibg=#5d6f71 ctermbg=240
hi LineNr       guifg=#5d6f71 guibg=#151515 ctermfg=240 ctermbg=233
hi Comment      guifg=#5d6f71 ctermfg=240
hi Constant     guifg=#fc595f ctermfg=203
hi Identifier   guifg=#df9395 ctermfg=181
hi Statement    guifg=#832e31 ctermfg=131
hi PreProc      guifg=#a63c40 ctermfg=131
hi Type         guifg=#ba8586 ctermfg=181
hi Special      guifg=#d3494e ctermfg=167
hi Underlined   guifg=#fc595f ctermfg=203
hi Todo         guifg=#151515 guibg=#fc595f ctermfg=233 ctermbg=203
