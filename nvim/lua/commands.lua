-- VIM COMMANDS

vim.cmd("command W execute 'w'")
vim.cmd("command Go execute '!cd %:h && go run %'")
vim.cmd("command GoMain execute '!go run main.go'")
vim.cmd("command Vlang execute '!v run %'")
vim.cmd("command NimSilent execute '!nim r --verbosity:0 %'")
vim.cmd("command Nim execute '!nim r %'")
vim.cmd("command Tsx execute '!tsx %'")
vim.cmd("command! -complete=shellcmd -nargs=+ Shell call ExecuteInShell(<q-args>)")

local function HideDiagnostics()
  return vim.diagnostic.config({virtual_text = false, underline = false, signs = false})
end


local function ShowDiagnostics()
  return vim.diagnostic.config({virtual_text = true, signs = true, underline = true})
end

vim.api.nvim_create_user_command("HideDiagnostics", HideDiagnostics, {force = true})
vim.api.nvim_create_user_command("ShowDiagnostics", ShowDiagnostics, {force = true})
