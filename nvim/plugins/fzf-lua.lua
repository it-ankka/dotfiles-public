local Plug = vim.fn['plug#']

Plug ('ibhagwan/fzf-lua', {branch = 'main'})


vim.api.nvim_create_user_command("Files",
    function()
        require('fzf-lua').files({
                fd_opts = "--type f --hidden --exclude node_modules --exclude .git",
                find_opts = "-type f -not -path '*/node_modules/*' -printf '%P\n'"
    }) end, {})

vim.api.nvim_create_user_command("AllFiles",
    function()
        require('fzf-lua').files({
                fd_opts = "--type f --hidden --exclude .git",
                find_opts = "-type f -not -path '*/.git/*' -printf '%P\n'",
                cmd = "find -type f -not -path '*/.git/*' -printf '%P\n'",
                git_icons = false,
                file_icons = false
    }) end, {})
vim.api.nvim_create_user_command("GrepAll",function()
    require('fzf-lua').grep({
        cmd='rg -uu --color=always --smart-case -g !{.git}',
        git_icons = false,
        file_icons = false
    }) end, {})
--Diagnostics
vim.api.nvim_create_user_command("Diagnostics",function()
    require('fzf-lua').lsp_document_diagnostics() end, {})
--All Diagnostics
vim.api.nvim_create_user_command("AllDiagnostics",function()
    require('fzf-lua').lsp_workspace_diagnostics() end, {})

-- Files search
vim.api.nvim_set_keymap('n',
    '<c-P>',
    "<cmd>AllFiles<CR>",
    { noremap = true, silent = true })
-- All Files search
vim.api.nvim_set_keymap('n',
    '<leader>F',
    "<cmd>AllFiles<CR>",
    { noremap = true, silent = true })
-- Files search
vim.api.nvim_set_keymap('n',
    '<leader>f',
    "<cmd>Files<CR>",
    { noremap = true, silent = true })
-- Grep All
vim.api.nvim_set_keymap('n',
    '<leader>R',
    "<cmd>GrepAll<CR>",
    { noremap = true, silent = true })
-- Grep
vim.api.nvim_set_keymap('n',
    '<leader>r',
    "<cmd>lua require('fzf-lua').grep_project()<CR>",
    { noremap = true, silent = true })
-- Buffers
vim.api.nvim_set_keymap('n',
    '<leader>b',
    "<cmd>lua require('fzf-lua').buffers()<CR>",
    { noremap = true, silent = true })
-- LSP references
vim.api.nvim_set_keymap('n',
    '<leader>gr',
    "<cmd>lua require('fzf-lua').lsp_references()<CR>",
    { noremap = true, silent = true })
-- LSP definitions
vim.api.nvim_set_keymap('n',
    '<leader>gd',
    "<cmd>lua require('fzf-lua').lsp_definitions()<CR>",
    { noremap = true, silent = true })
-- LSP declarations
vim.api.nvim_set_keymap('n',
    '<leader>gD',
    "<cmd>lua require('fzf-lua').lsp_declarations()<CR>",
    { noremap = true, silent = true })
-- LSP typedefs
vim.api.nvim_set_keymap('n',
    '<leader>gy',
    "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>",
    { noremap = true, silent = true })
-- LSP code actions
vim.api.nvim_set_keymap('n',
    '<leader>ga',
    "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>",
    { noremap = true, silent = true })
-- LSP code actions
vim.api.nvim_set_keymap('n',
    '<leader>gq',
    "<cmd>AllDiagnostics<CR>",
    { noremap = true, silent = true })
vim.api.nvim_create_autocmd("User", {
    pattern = "PlugLoaded",
    nested = true,
    callback = function() require'fzf-lua'.setup({
                winopts = { width = 0.8, height = 0.8 },
        }) end,
})
