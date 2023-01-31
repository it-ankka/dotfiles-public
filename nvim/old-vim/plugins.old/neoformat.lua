local Plug = vim.fn['plug#']
Plug 'sbdchd/neoformat'

vim.api.nvim_set_keymap("n", "<leader>pf", "<cmd>Neoformat<CR>", {noremap = true})
vim.api.nvim_set_keymap("v", "<leader>pf", "<cmd>Neoformat<CR>", {noremap = true})
