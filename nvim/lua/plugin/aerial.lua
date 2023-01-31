require("aerial").setup({filter_kind = false})

vim.api.nvim_set_keymap("n", "{", "<cmd>AerialPrev<CR>", {})
vim.api.nvim_set_keymap("n", "}", "<cmd>AerialNext<CR>", {})
vim.api.nvim_set_keymap("n", "[[", "<cmd>AerialPrevUp<CR>", {})
vim.api.nvim_set_keymap("n", "]]", "<cmd>AerialNextUp<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>A", "<cmd>AerialToggle! left<CR>", {})
