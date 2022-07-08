local Plug = vim.fn['plug#']
Plug 'nvim-lualine/lualine.nvim'

vim.api.nvim_create_autocmd("User", {
    pattern = "PlugLoaded",
    nested = true,
    callback = function() require'lualine'.setup({ theme = 'powerline' }) end,
})
