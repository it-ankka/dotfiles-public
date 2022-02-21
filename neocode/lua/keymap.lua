--[[
 _   _-
| | / /
| |/ /  ___ _   _ _ __ ___   __ _ _ __  ___
|    \ / _ \ | | | '_ ` _ \ / _` | '_ \/ __|
| |\  \  __/ |_| | | | | | | (_| | |_) \__ \
\_| \_/\___|\__, |_| |_| |_|\__,_| .__/|___/
             __/ |               | |
            |___/                |_|
--]]
local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', opts)

-- Copy and paste like VS code
-- vim.api.nvim_set_keymap('n', '<C-x>', 'dd', opts)
-- vim.api.nvim_set_keymap('n', '<C-v>', 'p', opts)
-- vim.api.nvim_set_keymap('i', '<C-v>', 'p', opts)

-- jump forward and backwards in document using crtl + j or k
-- vim.api.nvim_set_keymap('n', '<C-j>', '<C-f>', opts)
-- vim.api.nvim_set_keymap('n', '<C-k>', '<C-b>', opts)

-- vim.api.nvim_set_keymap('n', '<C-t>', ':ToggleTerm<CR>', opts)

-- Use lazygit to handle github repos
-- local status_ok, toggleterm = pcall(require, "toggleterm.terminal")
-- if not status_ok then
-- 	return
-- end
-- local lazygit = toggleterm.Terminal:new({ cmd = "lazygit", hidden = true, dir = "git_dir" })
--
-- function _lazygit_toggle()
--   lazygit:toggle()
-- end
--
-- vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

-- switch tabs using gt and gy
-- we can't really use ctrl+tab in the terminal, sadly
-- vim.api.nvim_set_keymap('n', 'gt', ':BufferLineCyclePrev<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gy', ':BufferLineCycleNext<CR>', opts)

-- vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope git_files<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<C-c>", ":Telescope commands<CR>", opts)
-- vim.api.nvim_set_keymap("n", "<C-O>", ":AerialToggle right<CR>", opts)
-- vim.api.nvim_set_keymap('n',
--   '<C-O>',
--   ':Telescope lsp_document_symbols prompt_prefix=🔍<CR>',
--   opts)

-- GENERAL MAPPINGS

-- Remove previous search
vim.api.nvim_set_keymap("n", "<leader>k", ":nohlsearch<CR>", opts)

-- Paste replace selection without yank
vim.api.nvim_set_keymap("v", "<leader>p", '"_dP', opts)
-- Delete without yank
vim.api.nvim_set_keymap("n", "<leader>d", '"_d', opts)
vim.api.nvim_set_keymap("n", "x", '"_x', opts)

-- Select all
vim.api.nvim_set_keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Other
vim.api.nvim_set_keymap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader><leader>b", ":Telescope buffers<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader><leader>g", ":Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader><leader>w", ":Telescope workspaces<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader><leader>c", ":CommentToggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader><leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- Moving lines
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", opts)
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", opts)
vim.api.nvim_set_keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
vim.api.nvim_set_keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
vim.api.nvim_set_keymap("n", "√", ":m .+1<CR>==", opts)
vim.api.nvim_set_keymap("n", "ª", ":m .-2<CR>==", opts)
vim.api.nvim_set_keymap("i", "√", "<Esc>:m .+1<CR>==gi", opts)
vim.api.nvim_set_keymap("i", "ª", "<Esc>:m .-2<CR>==gi", opts)
vim.api.nvim_set_keymap("v", "√", ":m '>+1<CR>gv=gv", opts)
vim.api.nvim_set_keymap("v", "ª", ":m '<-2<CR>gv=gv", opts)


-- folding
-- vim.api.nvim_set_keymap("n", "<C-]>", "za", opts)
-- vim.api.nvim_set_keymap("n", "<C-[>", "zc", opts)

-- Stay in indent mode
vim.api.nvim_set_keymap("v", "<", "<gv", opts)
vim.api.nvim_set_keymap("v", ">", ">gv", opts)

-- visual block comment
-- vim.api.nvim_set_keymap("v", "<leader><leader>c", ":CommentToggle<CR>", opts)

-- As a side note, some additional keymaps exist in the LSP-setup.lua file
-- for the language server commands such as gd for go to definition
