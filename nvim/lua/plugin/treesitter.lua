local ts = require("nvim-treesitter")
local ts_languages = {
  "bash", "clojure", "css", "fennel", "fish", "go", "html",
  "javascript", "json", "lua", "markdown", "php", "prisma",
  "rust", "scss", "svelte", "toml", "tsx", "typescript", "yaml"
}
ts.install(ts_languages)

vim.api.nvim_create_autocmd("FileType", {
  pattern = ts_languages,
  callback = function()
    vim.treesitter.start()

    -- Enable Treesitter indentation
    -- Note: The quotes in the string are required exactly as shown.
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.treesitter.language.register("tsx", "typescriptreact")

vim.api.nvim_create_user_command("TSResync", function()
  vim.cmd("write | edit")
  vim.treesitter.stop()
  vim.treesitter.start()
end, {})
