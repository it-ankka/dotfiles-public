Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'


" lua
function! SetupNvimTree()
    nnoremap <leader>n :NvimTreeFindFileToggle<CR>
lua << EOF
    require'nvim-tree'.setup {
            view = {
                    side = "right",
                    width = 35
            },
            git = {
                    ignore = false
            }
        }
EOF
endfunction

autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
autocmd User PlugLoaded ++nested call SetupNvimTree()
