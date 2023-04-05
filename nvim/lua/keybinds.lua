-- KEYBINDS

-- Remove default binds 
vim.keymap.set({"n"}, "<F1>", "<Nop>", {silent = true})
vim.keymap.set({"n"}, "Q", "<Nop>", {silent = true})
vim.keymap.set({"n"}, "<Space>", "<Nop>", {silent = true})

-- Map leader keys
vim.g["mapleader"] = " "
vim.g["maplocalleader"] = ","

-- Quickly access config files
vim.keymap.set({"n"}, "<leader>vr", ":q <CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>ve", ":FzfLua files cwd=~/.config/nvim/ <CR>", {silent = true})


vim.keymap.set({"n"}, "<leader>k", ":nohlsearch <CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>Q", ":bufdo bdelete <CR>", {silent = true})

-- Toggle linewrap
vim.keymap.set({"n"}, "<leader>w", ":set wrap!<CR>", {silent = true})

-- Tab switching
vim.keymap.set({"n"}, "<M-Left>", ":bp<cr>", {remap = true, silent = true})
vim.keymap.set({"n"}, "<M-Right>", ":bn<cr>", {remap = true, silent = true})
vim.keymap.set({"n"}, "<M-h>", ":bp<cr>", {remap = true, silent = true})
vim.keymap.set({"n"}, "<M-l>", ":bn<cr>", {remap = true, silent = true})
vim.keymap.set({"n"}, "˛", ":bp<cr>", {remap = true, silent = true})
vim.keymap.set({"n"}, "ﬁ", ":bn<cr>", {remap = true, silent = true})

-- Allow gf to open non-existent files
vim.keymap.set({"n"}, "gf", ":edit <cfile><cr>", {silent = true})

-- Reselect visual selection after indenting
vim.keymap.set({"v"}, "<", "<gv", {silent = true})
vim.keymap.set({"v"}, ">", ">gv", {silent = true})

-- Smart indent when entering insert mode with I on empty lines
vim.keymap.set({"n"}, "I", "IndentWithI('I')", {expr = true, silent = true})

-- Make Y behave like the other capitals
vim.keymap.set({"n"}, "Y", "y$", {silent = true})

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided
vim.cmd("noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')")
vim.cmd("noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')")

-- Paste replace visual selection without copying it
vim.keymap.set({"v"}, "p", "\"_dP", {silent = true})
-- Delete without yank
vim.keymap.set({"n"}, "<leader>d", "\"_d", {silent = true})
vim.keymap.set({"n"}, "<leader>x", "\"_x", {silent = true})

-- Delete word in insertmode
vim.keymap.set({"i"}, "<M-BS>", "<C-\\><C-o>\"_dB", {silent = true})

-- Easy insertion of a trailing ; or , from insert mode
vim.keymap.set({"n"}, ";;", "<Esc>mpA;<Esc>`p", {silent = true})
vim.keymap.set({"n"}, ",,", "<Esc>mpA,<Esc>`p", {silent = true})

-- Keep search terms in middle
vim.keymap.set({"n"}, "n", "nzzzv", {silent = true})
vim.keymap.set({"n"}, "N", "Nzzzv", {silent = true})

-- Keep jumping in middle
vim.keymap.set({"n"}, "<C-u>", "<C-u>zz", {silent = true})
vim.keymap.set({"n"}, "<C-d>", "<C-d>zz", {silent = true})

-- Join lines without moving cursor
vim.keymap.set({"n"}, "J", "mzJ`z", {silent = true})

-- Easy insertion of newline at cursor
vim.keymap.set({"n"}, "<leader><CR>", "a<CR><Esc>", {silent = true})

-- Split window
vim.keymap.set({"n"}, "ss", ":split<Return><C-w>w", {silent = true})
vim.keymap.set({"n"}, "sv", ":vsplit<Return><C-w>w", {silent = true})

-- Resize splits
vim.keymap.set({"n"}, "<Leader>+", ":vertical resize +5<CR>", {silent = true})
vim.keymap.set({"n"}, "<Leader>-", ":vertical resize -5<CR>", {silent = true})
vim.keymap.set({"n"}, "<Leader>h+", ":horizontal resize +5<CR>", {silent = true})
vim.keymap.set({"n"}, "<Leader>h-", ":horizontal resize -5<CR>", {silent = true})

-- Window movement
vim.keymap.set({"n"}, "<c-h>", "<c-w>h", {silent = true})
vim.keymap.set({"n"}, "<c-j>", "<c-w>j", {silent = true})
vim.keymap.set({"n"}, "<c-k>", "<c-w>k", {silent = true})
vim.keymap.set({"n"}, "<c-l>", "<c-w>l", {silent = true})

-- Quick play macros on the number row
vim.keymap.set({"n"}, "<F13>", "@1", {silent = true})
vim.keymap.set({"n"}, "<F14>", "@2", {silent = true})
vim.keymap.set({"n"}, "<F15>", "@3", {silent = true})
vim.keymap.set({"n"}, "<F16>", "@4", {silent = true})
vim.keymap.set({"n"}, "<F17>", "@5", {silent = true})
vim.keymap.set({"n"}, "<F18>", "@6", {silent = true})
vim.keymap.set({"n"}, "<F19>", "@7", {silent = true})
vim.keymap.set({"n"}, "<F20>", "@8", {silent = true})
vim.keymap.set({"n"}, "<F21>", "@9", {silent = true})

-- Close buffer
vim.keymap.set({"n"}, "<C-c>", ":bp|bd #<CR>", {silent = true})

-- Allows for moving lines like in vscode
vim.keymap.set({"n"}, "<A-j>", ":m .+1<CR>==", {silent = true})
vim.keymap.set({"n"}, "<A-k>", ":m .-2<CR>==", {silent = true})
vim.keymap.set({"i"}, "<A-j>", "<Esc>:m .+1<CR>==gi", {silent = true})
vim.keymap.set({"i"}, "<A-k>", "<Esc>:m .-2<CR>==gi", {silent = true})
vim.keymap.set({"v"}, "<A-j>", ":m '>+1<CR>gv=gv", {silent = true})
vim.keymap.set({"v"}, "<A-k>", ":m '<-2<CR>gv=gv", {silent = true})

-- For mac
vim.keymap.set({"n"}, "√", ":m .+1<CR>==", {silent = true})
vim.keymap.set({"n"}, "ª", ":m .-2<CR>==", {silent = true})
vim.keymap.set({"i"}, "√", "<Esc>:m .+1<CR>==gi", {silent = true})
vim.keymap.set({"i"}, "ª", "<Esc>:m .-2<CR>==gi", {silent = true})
vim.keymap.set({"v"}, "√", ":m '>+1<CR>gv=gv", {silent = true})
vim.keymap.set({"v"}, "ª", ":m '<-2<CR>gv=gv", {silent = true})

vim.keymap.set({"c"}, "w!!", "%!sudo tee > /dev/null %", {silent = true})
