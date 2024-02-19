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

-- GdScript tabs
vim.cmd("autocmd FileType gdscript setlocal noexpandtab")

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("help_window_right", {}),
  pattern = { "*.txt" },
  callback = function()
    if vim.o.filetype == 'help' then
      vim.cmd.wincmd("L")
      vim.cmd(":vert resize 90")
    end
  end
})

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
