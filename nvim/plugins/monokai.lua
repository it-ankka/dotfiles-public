local Plug = vim.fn['plug#']
Plug 'tanvirtin/monokai.nvim'

vim.cmd([[
        augroup MonokaiOverrides
            autocmd!
            autocmd ColorScheme monokai highlight Normal guibg=none
            autocmd ColorScheme monokai highlight NonText ctermbg=none guibg=none
            autocmd ColorScheme monokai highlight MonokaiComment cterm=italic gui=italic
            autocmd User PlugLoaded ++nested colorscheme monokai
        augroup end
    ]])
