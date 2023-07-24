-- GENERAL OPTIONS

vim.opt["autoindent"] = true
vim.opt["backup"] = true
if(vim.loop.os_uname().sysname ~= "Windows_NT") then
  vim.opt["backupdir"] = (os.getenv("HOME") .. "/.local/share/nvim/backup/")
else 
  vim.opt["backupdir"] = (os.getenv("LocalAppData") .. "\\nvim-backup")
end 
vim.opt["breakindent"] = true
vim.opt["clipboard"] = "unnamedplus"
vim.opt["confirm"] = true
vim.opt["expandtab"] = true
vim.opt["fileencoding"] = "utf-8"
vim.opt["hidden"] = true
vim.opt["ignorecase"] = true
vim.opt["inccommand"] = "nosplit"
vim.opt["linebreak"] = true
vim.opt["list"] = true
vim.opt["listchars"] = "tab:│ ,eol:↴,trail:·"
vim.opt["foldenable"] = false
vim.opt["joinspaces"] = false
vim.opt["wrap"] = false
vim.opt["pumheight"] = 10
vim.opt["redrawtime"] = 10000
vim.opt["scrolloff"] = 8
vim.opt["sidescrolloff"] = 8
vim.opt["smartcase"] = true
vim.opt["smartindent"] = true
vim.opt["splitright"] = true
vim.opt["tabstop"] = 2
vim.opt["shiftwidth"] = 2
vim.opt["termguicolors"] = true
vim.opt["title"] = true
vim.opt["undofile"] = true
vim.opt["updatetime"] = 300
vim.opt["wildmode"] = "longest:full,full"

vim.opt["signcolumn"] = "yes"
vim.opt["number"] = true
vim.opt["relativenumber"] = true
vim.opt["cursorline"] = true

-- Set title
vim.cmd("let dir = fnamemodify(getcwd(), ':t') . ' - NVIM'")
vim.cmd("set titlestring=%{dir}")

-- Neovide
vim.cmd("set guifont=Iosevka:18")
vim.cmd("let g:neovide_transparency=0.9")
