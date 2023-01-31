local Plug = vim.fn['plug#']
Plug('APZelos/blamer.nvim', {['do']= ':BlamerShow' })

vim.g.blamer_enabled = 1
-- vim.cmd([['let g:blamer_enabled = 1']])
