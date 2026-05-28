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
  vim.keymap.set('n', '<leader><Left>', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
  vim.keymap.set('n', '<leader><Right>', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
  vim.keymap.set('n', '<leader>q', function() vim.diagnostic.setloclist() end, opts)
  vim.keymap.set('n', '<leader>pF', function() vim.lsp.buf.format({ async = true }) end, opts)

  -- Add EslintFixAll command
  if client.name == "eslint" then
    vim.api.nvim_create_user_command("EslintFixAll", function() EslintFixAll({ client = client, sync = true }) end, {})
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      group = vim.api.nvim_create_augroup("eslint_fix", { clear = false }),
      pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.vue" },
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

--------------------
-- ENABLE SERVERS --
--------------------
local servers = require("mason-lspconfig").get_installed_servers()
vim.lsp.enable(servers)
