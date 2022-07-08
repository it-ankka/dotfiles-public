local Plug = vim.fn['plug#']
Plug 'norcalli/nvim-colorizer.lua'

vim.api.nvim_create_autocmd("User", {
    pattern = "PlugLoaded",
    nested = true,
    callback = function() require'colorizer'.setup({}) end,
})
