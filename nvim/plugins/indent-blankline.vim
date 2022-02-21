Plug 'lukas-reineke/indent-blankline.nvim'

function! SetupBlankline()
    let g:indentLine_fileTypeExclude = ['dashboard']
    let g:indent_blankline_show_current_context=v:true
    let g:indent_blankline_show_current_context_start=v:true
    let g:markdown_syntax_conceal=0
    let g:vim_json_conceal=0
endfunction

autocmd User PlugLoaded ++nested call SetupBlankline()
