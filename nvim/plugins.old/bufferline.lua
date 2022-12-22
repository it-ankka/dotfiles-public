local Plug = vim.fn['plug#']
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'akinsho/bufferline.nvim'

local setupBufferLine = function()
    require("bufferline").setup{
    options = {
    diagnostics = "coc",
    offsets = {
      {
        filetype = "NvimTree",
        text = "📁 File Explorer",
        highlight = "Directory",
        
      }
    }
        }
    }
end
-- KEYBINDS

-- Movement between buffers
vim.api.nvim_set_keymap("n", "<M-l>", ":BufferLineCycleNext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<M-h>", ":BufferLineCyclePrev<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "ﬁ", ":BufferLineCycleNext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "˛", ":BufferLineCyclePrev<CR>", {noremap = true, silent = true})
-- Reorganize buffers
vim.api.nvim_set_keymap("n", "<S-M-l>", ":BufferLineMoveNext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<S-M-h>", ":BufferLineMovePrev<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "ﬂ", ":BufferLineMoveNext<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "˘", ":BufferLineMovePrev<CR>", {noremap = true, silent = true})
-- Pick a buffer
vim.api.nvim_set_keymap("n", "<M-b>", ":BufferLinePick<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "›", ":BufferLinePick<CR>", {noremap = true, silent = true})



vim.api.nvim_create_autocmd("User", {
    pattern = "PlugLoaded",
    nested = true,
    callback = setupBufferLine,
})
