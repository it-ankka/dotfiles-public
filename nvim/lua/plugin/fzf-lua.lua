local function Files()
  return (require("fzf-lua")).files({sync = true, fd_opts = "--type f --hidden --exclude node_modules --exclude .git", find_opts = "-type f -not -path '*/node_modules/*' -printf '%P'"})
end


local function AllFiles()
  return (require("fzf-lua")).files({sync = true, fd_opts = "--type f --hidden --exclude .git", find_opts = "-type f -not -path '*/.git/*' -printf '%P'", git_icons = false, file_icons = false})
end

local function GrepProject()
  return (require("fzf-lua")).grep_project({fzf_opts = {["--delimiter"] = "'[:]'"}})
end

local function GrepAll()
  return (require("fzf-lua")).grep({cmd = "rg -uu --color=always --smart-case -g !{.git}", git_icons = false, file_icons = false})
end


local function Diagnostics()
  return (require("fzf-lua")).lsp_document_diagnostics({sync = true, jump_to_single_result = true})
end


local function AllDiagnostics()
  return (require("fzf-lua")).lsp_workspace_diagnostics({sync = true, jump_to_single_result = true})
end

vim.api.nvim_create_user_command("Files", Files, {})
vim.api.nvim_create_user_command("AllFiles", AllFiles, {})
vim.api.nvim_create_user_command("GrepProject", GrepProject, {})
vim.api.nvim_create_user_command("GrepAll", GrepAll, {})
vim.api.nvim_create_user_command("Diagnostics", Diagnostics, {})
vim.api.nvim_create_user_command("AllDiagnostics", AllDiagnostics, {})

-- KEYMAPS
vim.keymap.set({"n"}, "<c-P>", "<cmd>AllFiles<CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>F", "<cmd>AllFiles<CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>f", "<cmd>Files<CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>R", "<cmd>GrepAll<CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>r", "<cmd>GrepProject<CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>b", "<cmd>lua require('fzf-lua').buffers()<CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>gr", "<cmd>lua require('fzf-lua').lsp_references({ sync = true, jump_to_single_result = true})<CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>gd", "<cmd>lua require('fzf-lua').lsp_definitions({ sync = true, jump_to_single_result = true})<CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>gD", "<cmd>lua require('fzf-lua').lsp_declarations({ sync = true, jump_to_single_result = true})<CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>gy", "<cmd>lua require('fzf-lua').lsp_typedefs({ sync = true, jump_to_single_result = true})<CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>ga", "<cmd>lua require('fzf-lua').lsp_code_actions()<CR>", {silent = true})
vim.keymap.set({"n"}, "<leader>gq", "<cmd>AllDiagnostics<CR>", {silent = true})

require("fzf-lua").setup({winopts = {width = 0.8, height = 0.8}})
