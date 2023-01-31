require("mason").setup({ui = {border = "single"}})

require("mason-lspconfig").setup({
  ensure_installed = {
    "sumneko_lua",
    "tsserver",
    "diagnosticls",
    "svelte",
    "clojure_lsp",
    "bashls",
    "dockerls",
    "gopls",
    "pyright",
    "emmet_ls",
    "vimls",
    "cssls",
    "prismals",
    "html",
    "jsonls",
    "tailwindcss"
  }
})
