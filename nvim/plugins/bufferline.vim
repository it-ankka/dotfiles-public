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
endfunction

autocmd User PlugLoaded ++nested call SetupBufferLine()
