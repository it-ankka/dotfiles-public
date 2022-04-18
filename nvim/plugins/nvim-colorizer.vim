Plug 'norcalli/nvim-colorizer.lua'

function SetupColorizer()
    lua require'colorizer'.setup()
endfunction

autocmd User PlugLoaded ++nested call SetupColorizer()
