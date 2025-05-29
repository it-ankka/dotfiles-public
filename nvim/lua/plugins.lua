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
  -- Lazy settings
  install = { colorscheme = { "habamax" } },
  ui = { border = "single" },
  -- Plugins
  spec = {
    -- LSP
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "stevearc/dressing.nvim",
        -- Mason
        {
          "williamboman/mason.nvim",
          dependencies = {
            "stevearc/dressing.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
          },
          config = function() require("plugin.mason") end
        },
        -- CMP
        {
          "hrsh7th/nvim-cmp",
          dependencies = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-emoji",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "onsails/lspkind.nvim",
            "saadparwaiz1/cmp_luasnip",
          },
          event = "InsertEnter",
          config = function() require("plugin.cmp") end
        },
      },
      config = function() require("plugin.lsp") end
    },
    "b0o/schemastore.nvim",
    "onsails/lspkind.nvim",
    "mfussenegger/nvim-ansible",
    -- Neovim lua API documentation
    {
      "folke/lazydev.nvim",
      ft = "lua",
      config = { library = { "nvim-dap-ui" } }
    },
    -- Autocomplete

    -- Debugging
    {
      "mfussenegger/nvim-dap",
      dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
      config = function() require("plugin.dap") end,
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
      "toppair/peek.nvim",
      event = { "VeryLazy" },
      build = "deno task --quiet build:fast",
      config = function()
        require("peek").setup({
          app = "browser"
        })
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
      end,
    },
    -- Dressing
    {
      "stevearc/dressing.nvim",
      config = {
        input = { relative = "editor" }
      }
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
      version = "v2.*"
    },
    "norcalli/nvim-colorizer.lua",
    -- Git
    {
      "APZelos/blamer.nvim",
      cmd = { "BlamerShow", "BlamerToggle" },
    },
    "lewis6991/gitsigns.nvim",
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
      config = function() require("plugin.comment") end
    },
    -- Statusline
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config =
      {
        theme = "powerline",
        options = {
          ignore_focus = {
            "dapui_watches", "dapui_breakpoints",
            "dapui_scopes", "dapui_console",
            "dapui_stacks", "dap-repl"
          }
        }
      }
    },
    -- Sessions
    {
      "rmagatti/auto-session",
      config = {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      }
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
    -- Coloring/theming
    "rktjmp/lush.nvim",
    -- Tpope the magic man
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "tpope/vim-surround",

    -- {"stevearc/overseer.nvim",
    --   config = function() require("overseer").setup() end
    -- },
    -- {"ThePrimeagen/refactoring.nvim",},
  }
})
