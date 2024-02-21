-------------------
-- ON_ATTACH --
-------------------
local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Create your keybindings here...
  local opts = { noremap = true, silent = true, buffer = true }

  vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.formatting({ async = true }) end, {})
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.keymap.set('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.keymap.set('n', '<leader><Left>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.keymap.set('n', '<leader><Right>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.keymap.set("n", "<leader>pF", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)

  --TODO: hack to fix semanticTokens
  if client.name == "omnisharp" then
    client.server_capabilities.semanticTokensProvider.legend = {
      tokenModifiers = { "static" },
      tokenTypes = { "comment", "excluded", "identifier", "keyword", "keyword", "number", "operator", "operator",
        "preprocessor", "string", "whitespace", "text", "static", "preprocessor", "punctuation", "string", "string",
        "class", "delegate", "enum", "interface", "module", "struct", "typeParameter", "field", "enumMember", "constant",
        "local", "parameter", "method", "method", "property", "event", "namespace", "label", "xml", "xml", "xml", "xml",
        "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml", "xml",
        "xml", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp", "regexp" }
    }
  end

  -- Add EslintFixAll command
  if client.name == "eslint" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end
end

-------------------
-- AUTOCOMMANDS --
-------------------
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    on_attach(client, bufnr)
  end
})

vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.formatting({ async = true }) end, {})

----------------
-- APPEARANCE --
----------------
local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  })

require('lspconfig.ui.windows').default_options = {
  border = _border
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  })

require('lspconfig.ui.windows').default_options = {
  border = _border
}

vim.lsp.protocol.CompletionItemKind = {
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

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

-----------
-- MASON --
-----------
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup({ ui = { border = _border } })

mason_lspconfig.setup({
  ensure_installed = {
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
    "tsserver",
    "vimls",
    "vls",
    "volar",
    "yamlls",
  }
})

---------------
-- LSPCONFIG --
---------------
local nvim_lsp = require 'lspconfig'
local configs = require 'lspconfig.configs'


-- Set up completion using nvim_cmp with LSP source
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

lsp_capabilities.offsetEncoding = "utf-8"
-- lsp_capabilities.offset_encoding = "utf-16"

local servers = mason_lspconfig.get_installed_servers()

-------------------
-- SETUP SERVERS --
-------------------
for _, server in ipairs(servers) do
  if nvim_lsp[server] == nil then
    print("not supported", server)
    goto continue
  end
  local lspft = nvim_lsp[server].filetypes
  if lspft ~= nil and #lspft > 0 then
    local ft = vim.bo.filetype
    local should_load = false
    for _, value in ipairs(lspft) do
      if ft == value then
        should_load = true
      end
    end
    if not should_load then
      goto continue
    end
  end
  local server_config = {
    on_attach = on_attach,
    capabilities = lsp_capabilities,
    flags = {
      debounce_text_changes = 500,
      allow_incremental_sync = true
    }
  }

  nvim_lsp[server].setup(server_config)
  ::continue::
end

----------------------------
-- SETUP SPECIFIC SERVERS --
----------------------------

--Fennel

if (vim.loop.os_uname().sysname ~= "Windows_NT") then
  configs.fennel_language_server = {
    default_config = {
      -- replace it with true path
      cmd = { os.getenv('HOME') .. '/.cargo/bin/fennel-language-server' },
      filetypes = { 'fennel' },
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
            globals = { 'vim' },
          },
        },
      },
    },
  }

  nvim_lsp.fennel_language_server.setup {}
end

--Lua ls
nvim_lsp.lua_ls.setup {
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
  capabilities = lsp_capabilities,
  flags = {
    debounce_text_changes = 500,
    allow_incremental_sync = true
  },
}

--TS/JS
nvim_lsp.tsserver.setup {
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'json', "typescript", "typescriptreact",
    "typescript.tsx" },
  capabilities = lsp_capabilities,
  flags = {
    debounce_text_changes = 150,
    -- allow_incremental_sync = true
  }
}

-- JSON
nvim_lsp.jsonls.setup {
  capabilities = lsp_capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
    flags = {
      debounce_text_changes = 150,
      --allow_incremental_sync = true
    }
  },
}

-- YAML
nvim_lsp.yamlls.setup {
  capabilities = lsp_capabilities,
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}

-- Emmet
nvim_lsp.emmet_ls.setup({
  capabilities = lsp_capabilities,
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

nvim_lsp.gdscript.setup({})
