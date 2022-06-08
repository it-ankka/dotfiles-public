Plug 'junegunn/goyo.vim'

function! s:goyo_enter()
  set nolist
  set listchars=
  set noshowmode
  set noshowcmd
endfunction

function! s:goyo_leave()
  set list
  set listchars=tab:\│\ ,eol:↴,trail:·
  set showmode
  set showcmd
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
