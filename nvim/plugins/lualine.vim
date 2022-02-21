Plug 'nvim-lualine/lualine.nvim'

function! SetupLualine()
lua << END
require('lualine').setup()
END
endfunction

autocmd User PlugLoaded ++nested call SetupLualine()
