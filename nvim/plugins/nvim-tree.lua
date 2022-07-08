local Plug = vim.fn['plug#']
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'


local setupNvimTree = function()
    vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', {noremap = true})
    require'nvim-tree'.setup {
            view = {
                    side = "right",
                    width = 35
            },
            git = {
                    ignore = false
            }
        }
end

vim.api.nvim_create_autocmd('BufEnter', {
    command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
    nested = true,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "PlugLoaded",
    nested = true,
    callback = setupNvimTree,
})
