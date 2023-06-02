-- Format on save
vim.cmd("autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.svelte Neoformat")
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
