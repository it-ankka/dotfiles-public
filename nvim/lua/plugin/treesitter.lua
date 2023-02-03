require("nvim-treesitter.configs").setup({
    highlight = {enable = true},
    content_commentstring = {enable = true},
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil
    },
    indent = {
      disable = {},
      enable = false
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
    }
  })

local parser_config = (require("nvim-treesitter.parsers")).get_parser_configs()
parser_config.tsx.filetype_to_parsername = {"javascript", "typescript.tsx"}

vim.api.nvim_create_user_command("TSResync", ":write | edit | TSBufEnable highlight", {})
