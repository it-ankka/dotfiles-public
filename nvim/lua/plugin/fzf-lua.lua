local fzf_lua = require("fzf-lua")

local Files = function()
  return fzf_lua.files({
    fd_opts = "--type f --hidden --exclude node_modules --exclude .git",
    find_opts = "-type f -not -path '*/node_modules/*' -printf '%P'",
    git_icons = true
  })
end

local Buffers = function()
  return fzf_lua.buffers({
    git_icons = true
  })
end

local AllFiles = function()
  return fzf_lua.files({
    fd_opts = "--type f --hidden --exclude .git",
    find_opts = "-type f -not -path '*/.git/*' -printf '%P'",
    git_icons = true,
  })
end

local GrepProject = function()
  return fzf_lua.grep_project({
    fzf_opts = { ["--delimiter"] = "'[:]'" }
  })
end

local GrepAll = function()
  return fzf_lua.grep({
    cmd = "rg -uu --color=always --smart-case -g !{.git}",
    git_icons = false,
    file_icons = false
  })
end

local Resume = function() return fzf_lua.resume() end

local AllDiagnostics = function() return fzf_lua.lsp_workspace_diagnostics() end
local AllSymbols = function() return fzf_lua.lsp_live_workspace_symbols() end
local CodeActions = function() fzf_lua.lsp_code_actions({ jump1 = false }) end
local Declarations = function() fzf_lua.lsp_declarations() end
local Definitions = function() fzf_lua.lsp_definitions() end
local Diagnostics = function() return fzf_lua.lsp_document_diagnostics() end
local References = function() fzf_lua.lsp_references() end
local Symbols = function() return fzf_lua.lsp_document_symbols() end
local TypeDefinitions = function() fzf_lua.lsp_typedefs() end

vim.api.nvim_create_user_command("Resume", Resume, {})

vim.api.nvim_create_user_command("AllFiles", AllFiles, {})
vim.api.nvim_create_user_command("AllSymbols", AllSymbols, {})
vim.api.nvim_create_user_command("CodeActions", CodeActions, {})
vim.api.nvim_create_user_command("Declarations", Declarations, {})
vim.api.nvim_create_user_command("Definitions", Definitions, {})
vim.api.nvim_create_user_command("Diagnostics", Diagnostics, {})
vim.api.nvim_create_user_command("References", References, {})
vim.api.nvim_create_user_command("Symbols", Symbols, {})
vim.api.nvim_create_user_command("TypeDefinitions", TypeDefinitions, {})

vim.api.nvim_create_user_command("AllDiagnostics", AllDiagnostics, {})
vim.api.nvim_create_user_command("Buffers", Buffers, {})
vim.api.nvim_create_user_command("Files", Files, {})
vim.api.nvim_create_user_command("GrepAll", GrepAll, {})
vim.api.nvim_create_user_command("GrepProject", GrepProject, {})

-- KEYMAPS
vim.keymap.set({ "n" }, "<c-P>", AllFiles, { silent = true })
vim.keymap.set({ "n" }, "<leader>F", Resume, { silent = true })
vim.keymap.set({ "n" }, "<leader>fF", AllFiles, { silent = true })
vim.keymap.set({ "n" }, "<leader>ff", Files, { silent = true })
vim.keymap.set({ "n" }, "<leader>fR", GrepAll, { silent = true })
vim.keymap.set({ "n" }, "<leader>fr", GrepProject, { silent = true })
vim.keymap.set({ "n" }, "<leader>fb", Buffers, { silent = true })

vim.keymap.set({ "n" }, "<leader>gD", Declarations, { silent = true })
vim.keymap.set({ "n" }, "<leader>ga", CodeActions, { silent = true })
vim.keymap.set({ "n" }, "<leader>gd", Definitions, { silent = true })
vim.keymap.set({ "n" }, "<leader>gs", Symbols, { silent = true })
vim.keymap.set({ "n" }, "<leader>gS", AllSymbols, { silent = true })
vim.keymap.set({ "n" }, "<leader>gr", References, { silent = true })
vim.keymap.set({ "n" }, "<leader>gy", TypeDefinitions, { silent = true })
vim.keymap.set({ "n" }, "<leader>gq", AllDiagnostics, { silent = true })

require("fzf-lua").setup({ winopts = { width = 0.9, height = 0.9 } })
