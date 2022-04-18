Plug 'daquexian/copilot.vim'
"Plug 'github/copilot.vim'

let g:copilot_no_maps = v:true
let g:copilot_assume_mapped = v:true

" KEYBINDS
imap <silent><script><expr> <S-Right> copilot#Accept("\<CR>")
imap <silent><script><expr> <S-Up> copilot#Previous()
imap <silent><script><expr> <S-Down> copilot#Next()

