-----------
-- MASON --
-----------
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")

mason.setup({
  ui = { border = "rounded" },
  -- Autoinstall formatters and linters
  mason_tool_installer.setup({
    ensure_installed = {
      "ansible-lint",
      "prettier",
      "prettierd",
      "clang-format",
      "csharpier",
      "isort",
      "black",
    }
  })
})

mason_lspconfig.setup({
  automatic_enable = {},
  automatic_installation = { exclude = { "fennel_language_server" } },
  ensure_installed = {
    "ansiblels",
    "astro",
    "bashls",
    "clangd",
    "clojure_lsp",
    "cssls",
    "diagnosticls",
    "dockerls",
    "emmet_ls",
    "eslint",
    "graphql",
    "html",
    "intelephense",
    "jsonls",
    "lemminx",
    "lua_ls",
    "marksman",
    "omnisharp",
    "perlnavigator",
    "prismals",
    "pyright",
    "rust_analyzer",
    "sqlls",
    "svelte",
    "tailwindcss",
    "ts_ls",
    "vimls",
    "vls",
    "yamlls",
  }
})
