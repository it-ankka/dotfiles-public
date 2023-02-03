local nvim_lsp = require 'lspconfig'
local configs = require 'lspconfig.configs'
local protocol = require 'vim.lsp.protocol'

-- Set borders
local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = _border
    }
    )

require('lspconfig.ui.windows').default_options = {
    border = _border
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

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
    -- buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
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
local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

capabilities.offsetEncoding = "utf-8"
-- capabilities.offset_encoding = "utf-16"

local servers = {
    "astro",
    "bashls",
    "clangd",
    "clojure_lsp",
    "cssls",
    "diagnosticls",
    "dockerls",
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

--Fennel
configs.fennel_language_server = {
 default_config = {
    -- replace it with true path
    cmd = {os.getenv('HOME') .. '/.cargo/bin/fennel-language-server'},
    filetypes = {'fennel'},
    single_file_support = true,
    -- source code resides in directory `fnl/`
    root_dir = nvim_lsp.util.root_pattern("fnl"),
    settings = {
      fennel = {
        workspace = {
          -- If you are using hotpot.nvim or aniseed,
          -- make the server aware of neovim runtime files.
          library = vim.api.nvim_list_runtime_paths(),
        },
        diagnostics = {
          globals = {'vim'},
        },
      },
    },
  },
}

nvim_lsp.fennel_language_server.setup{}

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

-- Emmet
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

-- Configure default setups
local defaultSetupTargets = {
    'dressing',
    'lsp_signature',
    'dim'
}
for _, value in pairs(defaultSetupTargets) do
    require(value).setup({})
end
