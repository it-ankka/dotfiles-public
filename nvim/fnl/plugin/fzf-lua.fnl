(import-macros {: map!} "hibiscus.vim")
(vim.api.nvim_create_user_command 
    :Files 
    #((. (require :fzf-lua) :files) 
      {:sync true 
       :fd_opts "--type f --hidden --exclude node_modules --exclude .git"
       :find_opts "-type f -not -path '*/node_modules/*' -printf '%P'"}) {})

(vim.api.nvim_create_user_command 
    :AllFiles 
    #((. (require :fzf-lua) :files) 
      {:sync true 
       :fd_opts "--type f --hidden --exclude .git"
       :find_opts "-type f -not -path '*/.git/*' -printf '%P'"
       :git_icons false
       :file_icons false}) {})

(vim.api.nvim_create_user_command 
    :GrepAll 
    #((. (require :fzf-lua) :grep) 
      {:cmd "rg -uu --color=always --smart-case -g !{.git}"
       :git_icons false :file_icons false}) {})

(vim.api.nvim_create_user_command 
    :Diagnostics 
    #((. (require :fzf-lua) :lsp_document_diagnostics) 
      {:sync true :jump_to_single_result true}) {})

(vim.api.nvim_create_user_command 
    :AllDiagnostics 
    #((. (require :fzf-lua) :lsp_workspace_diagnostics) 
      {:sync true :jump_to_single_result true}) {})

(map! [n :silent] :<c-P> :<cmd>AllFiles<CR>)
(map! [n :silent] :<leader>F :<cmd>AllFiles<CR>)
(map! [n :silent] :<leader>f :<cmd>Files<CR>)
(map! [n :silent] :<leader>R :<cmd>GrepAll<CR>)
(map! [n :silent] :<leader>r "<cmd>lua require('fzf-lua').grep_project()<CR>")
(map! [n :silent] :<leader>b "<cmd>lua require('fzf-lua').buffers()<CR>")
(map! [n :silent] :<leader>gr "<cmd>lua require('fzf-lua').lsp_references({ sync = true, jump_to_single_result = true})<CR>")
(map! [n :silent] :<leader>gd "<cmd>lua require('fzf-lua').lsp_definitions({ sync = true, jump_to_single_result = true})<CR>")
(map! [n :silent] :<leader>gD "<cmd>lua require('fzf-lua').lsp_declarations({ sync = true, jump_to_single_result = true})<CR>")
(map! [n :silent] :<leader>gy "<cmd>lua require('fzf-lua').lsp_typedefs({ sync = true, jump_to_single_result = true})<CR>")
(map! [n :silent] :<leader>ga "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>")
(map! [n :silent] :<leader>gq :<cmd>AllDiagnostics<CR>)

(let [fzf (require :fzf-lua)] (fzf.setup {:winopts {:width 0.8 :height 0.8}}))
