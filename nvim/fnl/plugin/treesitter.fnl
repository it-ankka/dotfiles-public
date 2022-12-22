(local configs (require :nvim-treesitter.configs))

(configs.setup {:highlight {:enable true}
                :content_commentstring {:enable true}
                :rainbow {:enable true :extended_mode true :max_file_lines nil}
                :indent {:enable false :disable {}}
                :ensure_installed [:tsx
                                   :toml
                                   :fish
                                   :php
                                   :json
                                   :yaml
                                   :html
                                   :scss
                                   :css
                                   :markdown
                                   :prisma
                                   :rust
                                   :svelte
                                   :fennel
                                   :clojure
                                   :prisma
                                   :javascript
                                   :typescript
                                   :bash
                                   :clojure]})

(local parser-config ((. (require :nvim-treesitter.parsers) :get_parser_configs)))
(set parser-config.tsx.filetype_to_parsername [:javascript :typescript.tsx])
(vim.api.nvim_create_user_command :TSResync ":write | edit | TSBufEnable highlight" {})	
