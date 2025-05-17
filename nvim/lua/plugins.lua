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

require('lazy').setup({
  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "ojroques/nvim-lspfuzzy",
      "stevearc/dressing.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    config = function() require("plugin.lsp") end
  },
  "b0o/schemastore.nvim",
  "ojroques/nvim-lspfuzzy",
  "onsails/lspkind.nvim",
  "mfussenegger/nvim-ansible",
  -- Neovim lua API documentation
  {
    "folke/lazydev.nvim",
    ft = "lua",
    config = function()
      require("lazydev").setup({
        library = { "nvim-dap-ui" },
      })
    end
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function() require("plugin.dap") end,
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" }
  },

  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp-signature-help"
      -- "PaterJason/cmp-conjure",
    },
    event = "InsertEnter",
    config = function() require("plugin.cmp") end
  },

  -- File search
  {
    "ibhagwan/fzf-lua",
    enabled = vim.fn.has('win32') ~= 1,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("plugin.fzf-lua") end
  },
  {
    'nvim-telescope/telescope.nvim',
    enabled = vim.fn.has('win32') == 1,
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' },
    config = function() require('plugin.telescope') end
  },
  {
    "jparise/vim-graphql",
    ft = { "graphql", "javascript", "typescript", "typescriptreact" }
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
    tag = "v2.*"
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function() require("colorizer").setup() end
  },
  -- Git
  {
    "APZelos/blamer.nvim",
    cmd = { "BlamerShow", "BlamerToggle" },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function() require('gitsigns').setup() end
  },
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
    },
    build = ":TSUpdate",
    config = function() require("plugin.treesitter") end
  },
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
    config = function()
      require("lualine").setup({
        theme = "powerline",
        options = {
          ignore_focus = {
            "dapui_watches", "dapui_breakpoints",
            "dapui_scopes", "dapui_console",
            "dapui_stacks", "dap-repl"
          }
        }
      })
    end
  },
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
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("plugin.aerial") end
  },
  -- Auto closing tags
  {
    "windwp/nvim-ts-autotag",
    ft = {
      'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
      'rescript',
      'xml',
      'php',
      'markdown',
      'astro', 'glimmer', 'handlebars', 'hbs'
    },
  },

  -- Conjure
  {
    "Olical/conjure",
    cmd = { "Lein", "Clj" },
    dependencies = { "PaterJason/cmp-conjure" },
    ft = { "clojure", "fennel", "lisp", "python" }
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

  -- Coloring/theming
  "folke/lsp-colors.nvim",
  "rktjmp/lush.nvim",
  -- Tpope the magic man
  "tpope/vim-dispatch",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-surround",

  -- {"stevearc/overseer.nvim",
  --   config = function() require("overseer").setup() end
  -- },
  -- {"ThePrimeagen/refactoring.nvim",},
}, {
  ui = {
    border = "single"
  }
})
