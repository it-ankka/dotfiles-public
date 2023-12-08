-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Map leader keys
vim.g["mapleader"] = " "
vim.g["maplocalleader"] = ","

local lazy = require('lazy').setup({
  {
    "AndrewRadev/tagalong.vim",
    ft = {
      "tsx",
      "javascript",
      "javascriptreact",
      "html",
      "svelte",
      "xml",
      "typescript",
      "typescriptreact"
    },
    config = function() require("plugin.tagalong") end
  },
  -- Conjure
  {
    "Olical/conjure",
    cmd = { "Lein", "Clj" },
    ft = { "clojure", "fennel", "lisp" }
  },
  {
    "PaterJason/cmp-conjure",
    cmd = { "Lein", "Clj" },
    ft = { "clojure", "fennel", "lisp" }
  },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup() end
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("plugin.bufferline") end
  },
  "clojure-vim/vim-jack-in",
  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "PaterJason/cmp-conjure",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp-signature-help"
    },
    config = function() require("plugin.cmp") end
  },

  -- File search
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("plugin.fzf-lua") end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' },
    config = function() require('plugin.telescope') end
  },
  {
    "jparise/vim-graphql",
    ft = { "graphql", "javascript", "typescript", "typescriptreact" }
  },
  {
    "junegunn/goyo.vim",
    ft = { "markdown", "mdx", "text" },
    cmd = "Goyo",
    build = ":Goyo"
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown", "mdx", "text" },
    build = function() vim.fn["mkdp#util#install"]() end,
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" }
  },
  -- Dressing
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = {
          relative = "editor",
        }
      })
    end
  },
  -- Filetree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("plugin.nvim-tree") end
  },
  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    tag = "v1.1.*"
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function() require("colorizer").setup() end
  },
  -- Git
  { "APZelos/blamer.nvim",    build = ":BlamerShow" },
  "lewis6991/gitsigns.nvim",
  { "airblade/vim-gitgutter", build = ":GitGutterEnable" },
  -- Linting
  {
    "mfussenegger/nvim-lint",
    config = function() require("plugin.lint") end
  },
  -- Syntax highlighting and AST
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring"
      --   "p00f/nvim-ts-rainbow", // DEPRACATED
    },
    -- commit = "a2d7e78",
    build = ":TSUpdate",
    config = function() require("plugin.treesitter") end
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "ojroques/nvim-lspfuzzy",
      "stevearc/dressing.nvim",
      "PaterJason/cmp-conjure",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
      -- "ray-x/lsp_signature.nvim",
      -- "narutoxy/dim.lua"
    },
    config = function() require("plugin.lsp") end
  },
  "ojroques/nvim-lspfuzzy",
  "onsails/lspkind.nvim",
  "evanleck/vim-svelte",
  -- Commenting
  {
    "numToStr/Comment.nvim",
    dependencies = { "Shougo/context_filetype.vim" },
    config = function() require("plugin.comment") end
  },
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("lualine").setup({ theme = "powerline" }) end
  },
  "radenling/vim-dispatch-neovim",
  -- Sessions
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      }
    end
  },

  -- Formatting
  { "stevearc/conform.nvim", config = function() require("plugin.conform") end },
  -- {"sbdchd/neoformat", config = function() require("plugin.neoformat") end },
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("plugin.aerial") end
  },
  -- Coloring/theming
  "folke/lsp-colors.nvim",
  "rktjmp/lush.nvim",
  -- Tpope the magic man
  "tpope/vim-dispatch",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-surround",

  -- {"stevearc/overseer.nvim",
  --   opt = true,
  --   config = function() require("overseer").setup() end
  -- },
  -- {"ThePrimeagen/refactoring.nvim", opt = true},
})
