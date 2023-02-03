local Plug = vim.fn['plug#']
Plug 'windwp/nvim-autopairs'

vim.api.nvim_create_autocmd("User", {
    pattern = "PlugLoaded",
    nested = true,
    callback = function() require('nvim-autopairs').setup({
                enable_moveright = false
        }) end,
})
