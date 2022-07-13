local Plug = vim.fn['plug#']
Plug 'sbdchd/neoformat'

vim.api.nvim_set_keymap("n", "<leader>pF", "<cmd>Neoformat<CR>", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>pF", "<cmd>Neoformat<CR>", {noremap = true})
