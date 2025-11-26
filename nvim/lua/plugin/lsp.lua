-------------------
-- ON_ATTACH --
-------------------
local on_attach = function(client, bufnr)
  local function buf_set_option(name, value) vim.bo[bufnr][name] = value end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Create your keybindings here...
  local opts = { noremap = true, silent = true, buffer = true }

  vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({ async = true }) end, {})
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'gy', function() vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
  vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
  -- vim.keymap.set('i', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', '<C-s>', function() vim.lsp.buf.signature_help({ border = "rounded" }) end, opts)
  vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', '<leader>ga', function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set('n', '<leader>e', function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set('n', '<leader><Left>', function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set('n', '<leader><Right>', function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set('n', '<leader>q', function() vim.diagnostic.setloclist() end, opts)
  vim.keymap.set('n', '<leader>pF', function() vim.lsp.buf.format({ async = true }) end, opts)

  -- Add EslintFixAll command
  if client.name == "eslint" then
    vim.api.nvim_create_user_command("EslintFixAll", function() EslintFixAll({ client = client, sync = true }) end, {})
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      group = vim.api.nvim_create_augroup("eslint_fix", { clear = false }),
      pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
      command = "silent! EslintFixAll",
    })
  end
end

function EslintFixAll(opts)
  opts = opts or {}

  local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
  vim.validate("bufnr", bufnr, "number")

  local client = opts.client or vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" })[1]

  if not client then return end

  local request

  if opts.sync then
    request = function(buf, method, params) client:request_sync(method, params, nil, buf) end
  else
    request = function(buf, method, params) client:request(method, params, nil, buf) end
  end

  request(bufnr, "workspace/executeCommand", {
    command = "eslint.applyAllFixes",
    arguments = {
      {
        uri = vim.uri_from_bufnr(bufnr),
        version = vim.lsp.util.buf_versions[bufnr],
      },
    },
  })
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

----------------
-- APPEARANCE --
----------------
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = "rounded" }
)
require('lspconfig.ui.windows').default_options = { border = "rounded" }

vim.diagnostic.config({
  float = { border = "rounded" }
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "󰋼 ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
})

-- Set up completion using nvim_cmp with LSP source
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

lsp_capabilities.offsetEncoding = "utf-8"


-------------------
-- SETUP SERVERS --
-------------------
vim.lsp.config('*', {
  capabilities = lsp_capabilities,
  flags = {
    debounce_text_changes = 500,
    allow_incremental_sync = true
  }
})

----------------------------
-- SETUP SPECIFIC SERVERS --
----------------------------

--Lua ls
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim', 'love' } },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
  capabilities = lsp_capabilities,
  flags = {
    debounce_text_changes = 500,
    allow_incremental_sync = true
  },
})

--TS/JS
vim.lsp.config("ts_ls", {
  filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'json', "typescript", "typescriptreact",
    "typescript.tsx" },
  capabilities = lsp_capabilities,
  flags = {
    debounce_text_changes = 150,
  }
})

-- JSON
vim.lsp.config("jsonls", {
  capabilities = lsp_capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
    flags = {
      debounce_text_changes = 150,
    }
  },
})

-- YAML
vim.lsp.config("yamlls", {
  capabilities = lsp_capabilities,
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
})

-- Emmet
vim.lsp.config("emmet_ls", {
  capabilities = lsp_capabilities,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  }
})

-- Roslyn
vim.lsp.config("roslyn", {
  settings = {
    ["csharp|background_analysis"] = {
      dotnet_analyzer_diagnostics_scope = "fullSolution",
      dotnet_compiler_diagnostics_scope = "fullSolution"
    },
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
      csharp_enable_inlay_hints_for_lambda_parameter_types = true,
      csharp_enable_inlay_hints_for_types = true,
      dotnet_enable_inlay_hints_for_indexer_parameters = true,
      dotnet_enable_inlay_hints_for_literal_parameters = true,
      dotnet_enable_inlay_hints_for_object_creation_parameters = true,
      dotnet_enable_inlay_hints_for_other_parameters = true,
      dotnet_enable_inlay_hints_for_parameters = true,
      dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
      dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
      dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
    },
    ["csharp|code_lens"] = {
      dotnet_enable_references_code_lens = true,
    },
  },
  filewatching = true
})

vim.lsp.enable("roslyn")

--------------------
-- ENABLE SERVERS --
--------------------
local servers = require("mason-lspconfig").get_installed_servers()
vim.lsp.enable(servers)
