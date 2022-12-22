Plug 'junegunn/goyo.vim'

function! s:goyo_enter()
  set nolist
  set listchars=
  set signcolumn=no
  set noshowmode
  set noshowcmd
  set wrap
endfunction

function! s:goyo_leave()
  set list
  set signcolumn=yes
  set listchars=tab:\│\ ,eol:↴,trail:·
  set showmode
  set showcmd
  set nowrap
endfunction

nnoremap <silent> <leader>md :Goyo<CR>
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
