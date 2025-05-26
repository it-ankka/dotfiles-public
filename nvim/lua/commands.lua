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
  return vim.diagnostic.config({ virtual_text = false, underline = false, signs = false })
end


local function ShowDiagnostics()
  return vim.diagnostic.config({ virtual_text = true, signs = true, underline = true })
end

vim.api.nvim_create_user_command("HideDiagnostics", HideDiagnostics, { force = true })
vim.api.nvim_create_user_command("ShowDiagnostics", ShowDiagnostics, { force = true })

vim.api.nvim_create_user_command("Clip", function(opts)
  local text = ""
  local is_wsl = vim.fn.has("wsl")
  if opts.range == 0 then
    text = vim.fn.getreg('"')
  else
    local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
    text = table.concat(lines, "\n")
  end

  if is_wsl then
    local clip = io.popen("clip.exe", "w")
    if clip then
      clip:write(text)
      clip:close()
    else
      print("Failed to open clip.exe")
    end
  else
    vim.fn.setreg("+", text)
  end
end, { range = true, desc = "Copy visually selected text or register content to Clipboard" })
