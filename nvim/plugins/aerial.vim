Plug 'stevearc/aerial.nvim'
function! SetupAerial()
lua << EOF
require("aerial").setup({
  on_attach = function(bufnr)
    -- Toggle the aerial window with <leader>a
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>A', '<cmd>AerialToggle!<CR>', {})
    -- Jump forwards/backwards with '{' and '}'
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
    -- Jump up the tree with '[[' or ']]'
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
  end
})
EOF
" KEYMAPS
nnoremap <leader>A :AerialToggle<CR>
nnoremap { :AerialPrev<CR>
nnoremap } :AerialNext<CR>
nnoremap [[ :AerialPrevUp<CR>
nnoremap ]] :AerialNextUp<CR>

endfunction

autocmd User PlugLoaded ++nested call SetupAerial()

