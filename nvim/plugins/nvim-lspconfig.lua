local Plug = vim.fn['plug#']
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'ray-x/lsp_signature.nvim'
Plug 'onsails/lspkind.nvim'
Plug 'narutoxy/dim.lua'
Plug 'ojroques/nvim-lspfuzzy'
Plug 'stevearc/aerial.nvim'
Plug 'stevearc/dressing.nvim'

--luasnip
Plug('L3MON4D3/LuaSnip', {['tag'] = "v<CurrentMajor>.*"})
-- For vsnip users.
-- Plug 'hrsh7th/cmp-vsnip'
-- Plug 'hrsh7th/vim-vsnip'

local setupAerial = function()
    require("aerial").setup({
        filter_kind = false,
        on_attach = function(bufnr)
            -- Toggle the aerial window with <leader>a
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>A', '<cmd>AerialToggle! left<CR>', {})
            -- Jump forwards/backwards with '{' and '}'
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
            -- Jump up the tree with '[[' or ']]'
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
        end
    })
end


-- local setupLspFuzzy = function()
--     require('lspfuzzy').setup {
--         methods = 'all', -- either 'all' or a list of LSP methods (see below)
--         jump_one = true, -- jump immediately if there is only one location
--         save_last = false, -- save last location results for the :LspFuzzyLast command
--         fzf_modifier = ':~:.', -- format FZF entries, see |filename-modifiers|
--         fzf_trim = true, -- trim FZF entries
--     }
-- end

local setupLsp = function()
    --vim.lsp.set_log_level("debug")
    local nvim_lsp = require('lspconfig')
    local protocol = require 'vim.lsp.protocol'

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Aerial
        require("aerial").on_attach(client, bufnr)
        --Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap = true, silent = true }

        vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.formatting({ async = true }) end, {})
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        --buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '<leader><Left>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', '<leader><Right>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclistt()<CR>', opts)
        buf_set_keymap("n", "<leader>pF", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)


        --protocol.SymbolKind = { }
        protocol.CompletionItemKind = {
            '', -- Text
            '', -- Method
            '', -- Function
            '', -- Constructor
            '', -- Field
            '', -- Variable
            '', -- Class
            'ﰮ', -- Interface
            '', -- Module
            '', -- Property
            '', -- Unit
            '', -- Value
            '', -- Enum
            '', -- Keyword
            '﬌', -- Snippet
            '', -- Color
            '', -- File
            '', -- Reference
            '', -- Folder
            '', -- EnumMember
            '', -- Constant
            '', -- Struct
            '', -- Event
            'ﬦ', -- Operator
            '', -- TypeParameter
        }
    end


    -- Set up completion using nvim_cmp with LSP source
    local capabilities = require('cmp_nvim_lsp').update_capabilities(
        vim.lsp.protocol.make_client_capabilities()
    )

    local servers = {
        "astro",
        "bashls",
        "ccls",
        "diagnosticls",
        "dockerls",
        "gdscript",
        "gopls",
        "graphql",
        "html",
        "intelephense",
        "jsonls",
        "marksman",
        "nimls",
        "omnisharp",
        "perlnavigator",
        "prismals",
        "pyright",
        "rust_analyzer",
        "sqls",
        "svelte",
        "tailwindcss",
        "vimls",
        "vls",
        "yamlls",
        "zk"
        -- "emmet_ls",
    }

    for _, server in pairs(servers) do
        nvim_lsp[server].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 500,
                allow_incremental_sync = true
            }
        }
    end

    --Sumneko Lua
    nvim_lsp.sumneko_lua.setup {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim', 'love' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 500,
            allow_incremental_sync = true
        },
    }

    --Eslint
    nvim_lsp.eslint.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 500,
            allow_incremental_sync = true
        },
        handlers = {
            ['window/showMessageRequest'] = function(_, result, _) return result end,
        }
    }


    --TS/JS
    nvim_lsp.tsserver.setup {
        on_attach = on_attach,
        filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'json', "typescript", "typescriptreact",
            "typescript.tsx" },
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
            --allow_incremental_sync = true
        }
    }
    nvim_lsp.emmet_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
        init_options = {
            html = {
                options = {
                    -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                    ["bem.enabled"] = true,
                },
            },
        },
        flags = {
            debounce_text_changes = 150,
            --allow_incremental_sync = true
        }
    })
    --OMNISHARP
    -- require'lspconfig'.omnisharp.setup {
    --     cmd = { "/home/lassi/omnisharp/OmniSharp" },
    --     enable_editorconfig_support = true,
    --     enable_ms_build_load_projects_on_demand = false,
    --     enable_roslyn_analyzers = false,
    --     organize_imports_on_format = false,
    --     enable_import_completion = false,
    --     sdk_include_prereleases = true,
    --     analyze_open_documents_only = false,
    -- }
    vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

    -- suppress error messages from lang servers
    vim.notify = function(msg, log_level, _)
        if msg:match 'exit code' then
            return
        end
        if log_level == vim.log.levels.ERROR then
            vim.api.nvim_err_writeln(msg)
        else
            vim.api.nvim_echo({ { msg } }, true, {})
        end
    end

end

local setupCompletion = function()

    vim.o.completeopt = 'menu,menuone,noselect'

    -- Setup nvim-cmp.
    local cmp = require 'cmp'
    local lspkind = require('lspkind')

    cmp.setup({
        formatting = {
            format = lspkind.cmp_format({
                mode = 'symbol_text', -- show only symbol annotations
                maxwidth = 50,
            })
        },
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        mapping = {
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ['<C-e>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
            ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
            ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
            ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline', keyword_pattern = [=[[^[:blank:]\!]*]=] }
        })
    })


    -- Setup lspconfig.
    local _capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

-- autocmd User PlugLoaded ++nested lua require('dim').setup({})
-- autocmd User PlugLoaded ++nested lua require('dressing').setup({})
-- autocmd User PlugLoaded ++nested lua require("nvim-lsp-installer").setup({})
-- autocmd User PlugLoaded ++nested lua require("lsp_signature").setup({})
-- autocmd User PlugLoaded ++nested call SetupAerial()
-- autocmd User PlugLoaded ++nested call SetupLspFuzzy()
-- autocmd User PlugLoaded ++nested call SetupLsp()
-- autocmd User PlugLoaded ++nested call SetupCompletion()

vim.api.nvim_create_autocmd("User", {
    pattern = "PlugLoaded",
    nested = true,
    callback = function()
        local defaultSetupTargets = { 'dim', 'dressing', 'nvim-lsp-installer', 'lsp_signature' }
        for _, value in pairs(defaultSetupTargets) do
            require(value).setup({})
        end
        setupAerial()
        -- setupLspFuzzy()
        setupLsp()
        setupCompletion()
    end
})
