-- Commenting in nim files
vim.cmd("autocmd FileType nim setlocal commentstring=#\\ %s")

-- Make sure html files are html files
vim.cmd("autocmd BufRead,BufNewFile *.html set filetype=html")

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
