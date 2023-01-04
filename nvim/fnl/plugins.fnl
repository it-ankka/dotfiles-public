(import-macros {: exec} :hibiscus.vim)
(import-macros {: packer : packer-setup : use!} :hibiscus.packer)

(exec [[:packadd :matchit]])

(packer-setup {:max_jobs 10})

(packer
  (use! :AndrewRadev/tagalong.vim
        :ft [:tsx :javascript :javascriptreact :html :xml :typescript :typescriptreact]
        :config #(require :plugin.tagalong))
  (use! :Olical/conjure
        :opt true
        :cmd [:Lein :Clj]
        :ft [:clojure :fennel :lisp])
  (use! :PaterJason/cmp-conjure
        :opt true
        :cmd [:Lein :Clj]
        :ft [:clojure :fennel :lisp])
  ;; Autoclose
  (use! :m4xshen/autoclose.nvim
        :config #(let [autoclose (require :autoclose)] 
                   (autoclose.setup {})))
  ;; Bufferline
  (use! :akinsho/bufferline.nvim 
        :requires :kyazdani42/nvim-web-devicons
        :config #(require :plugin.bufferline))
  (use! :clojure-vim/vim-jack-in)
  ;; (use! :cohama/lexima.vim)
  ;; Autocomplete
  (use! :hrsh7th/nvim-cmp 
                :requires [:hrsh7th/cmp-nvim-lsp
                          :PaterJason/cmp-conjure
                          :hrsh7th/cmp-buffer
                          :hrsh7th/cmp-path
                          :hrsh7th/cmp-cmdline
                          :L3MON4D3/LuaSnip
                          :onsails/lspkind.nvim
                          :saadparwaiz1/cmp_luasnip
                          :hrsh7th/cmp-calc
                          :hrsh7th/cmp-emoji] ;
                :config #(require :plugin.cmp))
  ;; FZF
  (use! :ibhagwan/fzf-lua 
        :requires :kyazdani42/nvim-web-devicons
        :config #(require :plugin.fzf-lua))
  (use! :jparise/vim-graphql
        :ft [:graphql :javascript :typescript :typescriptreact])
  (use! :junegunn/goyo.vim 
        :ft [:markdown :mdx :text] 
        :cmd :Goyo
        :run ":Goyo")
  ;; Nvim-Tree
  (use! :kyazdani42/nvim-tree.lua 
        :requires :kyazdani42/nvim-web-devicons
        :config #(require :plugin.nvim-tree))
  (use! :L3MON4D3/LuaSnip :tag "v1.1.0.*")
  ;; Nvim Colorizer
  (use! :norcalli/nvim-colorizer.lua 
        :config #(let [c (require :colorizer)]
                   (c.setup {}) 
                   (c.reload_all_buffers)))
  ;; Git
  (use! :APZelos/blamer.nvim 
        :run ":BlamerShow")
  (use! :lewis6991/gitsigns.nvim)
  (use! :airblade/vim-gitgutter
        :run ":GitGutterEnable")
  ;; Mason
  (use! :williamboman/mason.nvim 
        :requires [:williamboman/mason-lspconfig.nvim]
        :config #(require :plugin.mason))
  ;;nvim-lint
  (use! :mfussenegger/nvim-lint
        :config #(require :plugin.lint))
  ;; Treesitter
  (use! :nvim-treesitter/nvim-treesitter 
        :requires [
                   :p00f/nvim-ts-rainbow 
                   :JoosepAlviste/nvim-ts-context-commentstring
                   ]
        :run ":TSUpdate"
        :config #(require :plugin.treesitter))
  ;; Lsp
  (use! :neovim/nvim-lspconfig
        :requires [
                   :hrsh7th/nvim-cmp
                   :ray-x/lsp_signature.nvim
                   :ojroques/nvim-lspfuzzy
                   :stevearc/dressing.nvim
                   :PaterJason/cmp-conjure
                   :narutoxy/dim.lua
                   ]
        :config #(require :plugin.lsp))
  (use! :ojroques/nvim-lspfuzzy)
  (use! :onsails/lspkind.nvim)
  (use! :ray-x/lsp_signature.nvim)
  ;; Some cool stuff
  ;; (use! :stevearc/overseer.nvim
  ;;       :config #(let [os (require :overseer)]
  ;;                  (os.config {})))
  ;; (use! :ThePrimeagen/refactoring.nvim
  ;;       :opt true)
  (use! :evanleck/vim-svelte)
  (use! :numToStr/Comment.nvim
        :requires :Shougo/context_filetype.vim
        :opt true 
        :keys [:gc [:v :gc]]
        :config #(require :plugin.comment))
  ;; Lualine
  (use! :nvim-lualine/lualine.nvim
        :requires :kyazdani42/nvim-web-devicons
        :config #(let [l (require :lualine)]
                   (l.setup {:theme :powerline})))
  (use! :radenling/vim-dispatch-neovim)
  (use! :rmagatti/auto-session)
  (use! :sbdchd/neoformat
        :config #(require :plugin.neoformat))
  (use! :sheerun/vim-polyglot)
  (use! :stevearc/aerial.nvim
        :config #(require :plugin.aerial))
  ;; Themes
  (use! :folke/lsp-colors.nvim)
  (use! :rktjmp/lush.nvim)
  (use! :tanvirtin/monokai.nvim)
  ;; (use! :eemed/sitruuna.vim)
  ;; (use! :d11wtq/subatomic256.vim)
  ;; (use! :veloce/vim-aldmeris)
  (use! :hwadii/gruber_darker.nvim)
  ;; TPope the magic man
  (use! :tpope/vim-dispatch)
  (use! :tpope/vim-fugitive)
  (use! :tpope/vim-rhubarb)
  (use! :tpope/vim-surround)
  ;; Fennel
  (use! :udayvir-singh/hibiscus.nvim)
  (use! :udayvir-singh/tangerine.nvim)
  )

; Setup Nvim-Tree
(let [nt (require :nvim-tree)]
  (nt.setup {:view {:side :right :width 35} :git {:ignore false}}))
