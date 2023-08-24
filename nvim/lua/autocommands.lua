-- Format on save
vim.cmd("autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.svelte Neoformat")

-- Run Eslint fixes on save
-- vim.cmd("autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx, EslintFixAll")

-- Set correct filetype for vlang
vim.cmd("autocmd BufRead,BufNewFile *.v set filetype=vlang")

-- Set correct filetype for gdscript
vim.cmd("autocmd BufRead,BufNewFile *.gd set filetype=gdscript")

-- Set correct filetype for prisma
vim.cmd("autocmd BufRead,BufNewFile *.prisma set filetype=prisma")

-- Set correct filetype for postcss
vim.cmd("autocmd BufRead,BufNewFile *.postcss set filetype=css")

-- Commenting in nim files
vim.cmd("autocmd FileType nim setlocal commentstring=#\\ %s")

-- Docs in clojure
vim.cmd("autocmd BufRead,BufNewFile *.clj nnoremap ,k :ConjureDocWord<CR>")

-- Docs in clojure
vim.cmd("autocmd FileType clojure nnoremap ,k :ConjureDocWord<CR>")

-- Terminal Settings
vim.cmd("autocmd TermOpen,TermEnter * setlocal signcolumn=no nonumber")

-- Markdown listchars
vim.cmd("autocmd BufNewFile,BufRead *.md set nolist filetype=markdown syntax=markdown")

-- Destroy NvimTree on quit
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local tree_wins = {}
    local floating_wins = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(tree_wins, w)
      end
      if vim.api.nvim_win_get_config(w).relative ~= '' then
        table.insert(floating_wins, w)
      end
    end
    if 1 == #wins - #floating_wins - #tree_wins then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(tree_wins) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end
})
