local Plug = vim.fn['plug#']
Plug 'sbdchd/neoformat'

vim.api.nvim_set_keymap("n", "<leader>pf", "<cmd>Neoformat<CR>", {noremap = true})
