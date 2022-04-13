Plug 'kyazdani42/nvim-web-devicons' 
Plug 'akinsho/bufferline.nvim'
function! SetupBufferLine()
lua << EOF
require("bufferline").setup{
options = {
diagnostics = "coc",
offsets = {
  {
    filetype = "nerdtree",
    text = "File Explorer",
    highlight = "Directory",
    text_align = "left"
  }
}
    }
}
EOF
" KEYBINDS

nnoremap <silent> <M-l> :BufferLineCycleNext<CR>
nnoremap <silent> <M-h> :BufferLineCyclePrev<CR>
nnoremap <silent> <S-M-l> :BufferLineMoveNext<CR>
nnoremap <silent> <S-M-h> :BufferLineMovePrev<CR>
nnoremap <silent> <M-b> :BufferLinePick<CR>
nnoremap <silent> ﬂ :BufferLineMoveNext<CR>
nnoremap <silent> ˘ :BufferLineMovePrev<CR>
nnoremap <silent> › :BufferLinePick<CR>
endfunction


autocmd User PlugLoaded ++nested call SetupBufferLine()
