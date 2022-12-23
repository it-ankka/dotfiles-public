
; Set correct filetype for vlang
(vim.cmd "autocmd BufRead,BufNewFile *.v set filetype=vlang")

; Set correct filetype for prisma
(vim.cmd "autocmd BufRead,BufNewFile *.prisma set filetype=prisma")

; Set correct filetype for postcss
(vim.cmd "autocmd BufRead,BufNewFile *.postcss set filetype=css")

; Commenting in nim files
(vim.cmd "autocmd FileType nim setlocal commentstring=#\\ %s")

; Docs in clojure
(vim.cmd "autocmd BufRead,BufNewFile *.clj nnoremap ,k :ConjureDocWord<CR>")

; Docs in clojure
(vim.cmd "autocmd FileType clojure nnoremap ,k :ConjureDocWord<CR>")

; Markdown listchars
(vim.cmd "autocmd BufNewFile,BufRead *.md set nolist")

; Terminal Settings
(vim.cmd "autocmd TermOpen,TermEnter * setlocal signcolumn=no nonumber")
