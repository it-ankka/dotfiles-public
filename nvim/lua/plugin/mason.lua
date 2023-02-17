require("mason").setup({ui = {border = "single"}})

require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "clojure_lsp",
    "cssls",
    "diagnosticls",
    "dockerls",
    "emmet_ls",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "omnisharp",
    "prismals",
    "pyright",
    "svelte",
    "tailwindcss",
    "tsserver",
    "vimls",
  }
})
