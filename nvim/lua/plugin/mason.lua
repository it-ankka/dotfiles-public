-----------
-- MASON --
-----------
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")
local mason_registry = require("mason-registry")

mason.setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
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
    "biome",
    "clangd",
    "clojure_lsp",
    "cssls",
    "diagnosticls",
    "dockerls",
    "emmet_ls",
    "eslint",
    "gopls",
    "graphql",
    "html",
    "intelephense",
    "jsonls",
    "lemminx",
    "lua_ls@3.15.0",
    "marksman",
    "perlnavigator",
    "prismals",
    "pyright",
    "rust_analyzer",
    "sqlls",
    "svelte",
    "tailwindcss",
    "ts_ls",
    "vimls",
    "vtsls",
    "vue_ls",
    "yamlls",
  }
})


mason_registry.refresh(function()
  local pkg = mason_registry.get_package("roslyn")

  if pkg ~= nil and not pkg:is_installed() then
    pkg:install()
    print("Mason installed")
  end
end)
