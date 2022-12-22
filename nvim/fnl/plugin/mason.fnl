(local mason (require :mason))
(local mason_lsp (require :mason-lspconfig))

(mason.setup {:ui {:border :single}})
(mason_lsp.setup 
    {
     :ensure_installed ["sumneko_lua" 
                        "tsserver"
                        "diagnosticls"
                        "svelte"
                        "clojure_lsp"
                        "bashls"
                        "dockerls"
                        "gopls"
                        "pyright"
                        "emmet_ls"
                        "vimls"
                        "cssls"
                        "prismals"
                        "html"
                        "jsonls"
                        "tailwindcss"]
     })

