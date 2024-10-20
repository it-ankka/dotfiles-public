local conform = require("conform")

local prettier = { { "prettierd", "prettier" } }

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    html = prettier,
    javascript = prettier,
    jsx = prettier,
    typescript = prettier,
    typescriptreact = prettier,
    svelte = prettier,
    tsx = prettier,
    json = prettier,
    jsonc = prettier,
    css = prettier,
    cs = { "csharpier" },
    c = { "clang-format" }
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
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
