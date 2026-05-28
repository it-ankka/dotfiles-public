local lint = require("lint")
lint.linters_by_ft = { vue = { "eslint" }, clojure = { "clj-kondo" }, ["yaml.ansible"] = { "ansible-lint" } }

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.vue", "*.clj", "*.yaml" },
  callback = function()
    lint.try_lint()
  end,
})
