require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = {
    disable = {},
    enable = false
  },
  autotag = {
    enable = true,
  },
  ensure_installed = {
    "bash",
    "clojure",
    "css",
    "fennel",
    "fish",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "php",
    "prisma",
    "rust",
    "scss",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "yaml"
  },
})

local parser_config = (require("nvim-treesitter.parsers")).get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

vim.api.nvim_create_user_command("TSResync", ":write | edit | TSBufEnable highlight", {})
