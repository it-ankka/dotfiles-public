local conform = require("conform")

local js_formatters = { "biome", "prettierd", "prettier", stop_after_first = true }

-- Commands to enable and disable autoformat
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

conform.setup({
  formatters = {
    biome = {
      require_cwd = true
    },
    yamlfix = {
      env = {
        YAMLFIX_INDENT_OFFSET = 0,
        YAMLFIX_INDENT_MAPPING = 2,
        YAMLFIX_INDENT_SEQUENCE = 2,
        YAMLFIX_EXPLICIT_START = "false",
        YAMLFIX_SEQUENCE_STYLE = "block_style",
        YAMLFIX_WHITELINES = "1"

      },
    }
  },
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    html = js_formatters,
    javascript = js_formatters,
    jsx = js_formatters,
    vue = js_formatters,
    typescript = js_formatters,
    typescriptreact = js_formatters,
    svelte = js_formatters,
    tsx = js_formatters,
    json = js_formatters,
    jsonc = js_formatters,
    css = js_formatters,
    cs = { "csharpier" },
    c = { "clang-format" },
    yaml = { "yamlfix" }
  },
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 2000, lsp_format = "fallback" }
  end,
})

vim.api.nvim_create_user_command("Conform", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({
    async = true,
    lsp_format = "fallback",
    range = range
  })
end, { range = true })

vim.keymap.set({ "n" }, "<leader>pf", "<cmd>Conform<CR>", { silent = false })
