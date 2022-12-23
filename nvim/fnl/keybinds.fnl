(import-macros {: g! : map!} :hibiscus.vim)

; Set leader keys 
(map! [n] "<F1>" "<Nop>")
(map! [n] "Q" "<Nop>")
(map! [n] "<Space>" "<Nop>")

(g! mapleader " ")
(g! maplocalleader ",")

(map! [n] "<leader>ve" ":edit ~/.config/nvim/init.fnl <CR>")
(map! [n] "<leader>vr" ":q <CR>")
(map! [n] "<leader>vl" ":edit ~/.config/nvim/fnl/plugin/lsp.lua <CR>")
(map! [n] "<leader>vf" ":edit ~/.config/nvim/fnl/functions.lua <CR>")
(map! [n] "<leader>vc" ":edit ~/.config/nvim/fnl/commands.fnl <CR>")
(map! [n] "<leader>vp" ":edit ~/.config/nvim/fnl/plugins.fnl <CR>")
(map! [n] "<leader>vk" ":edit ~/.config/nvim/fnl/keybinds.fnl <CR>")

(map! [n] "<leader>k" ":nohlsearch <CR>")
(map! [n] "<leader>Q" ":bufdo bdelete <CR>")

;; Toggle linewrap
(map! [n] "<leader>w" ":set wrap!<CR>")

;; Switch buffers
(map! [n :remap] "<M-Left>" ":bp<cr>")
(map! [n :remap] "<M-Right>" ":bn<cr>")
(map! [n :remap] "<M-h>" ":bp<cr>")
(map! [n :remap] "<M-l>" ":bn<cr>")
(map! [n :remap] "˛" ":bp<cr>")
(map! [n :remap] "ﬁ" ":bn<cr>")

;; Allow gf to open non-existent files
(map! [n] "gf" ":edit <cfile><cr>")

;; Reselect visual selection after indenting
(map! [v] "<" "<gv")
(map! [v] ">" ">gv")

;; Smart indent when entering insert mode with I on empty lines
(map! [n :expr] "I" "IndentWithI('I')")

;; Make Y behave like the other capitals
(map! [n] "Y" "y$")

;; When text is wrapped, move by terminal rows, not lines, unless a count is provided
(vim.cmd "noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')")
(vim.cmd "noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')")

;; Paste replace visual selection without copying it
(map! [v] "p" "\"_dP")

;; Delete without yank
(map! [n] "<leader>d" "\"_d")
(map! [n] "<leader>x" "\"_x")

;; Delete word in insertmode
(map! [i] "<M-BS>" "<C-\\><C-o>\"_dB")

;; Easy insertion of a trailing ; or , from insert mode
(map! [n] ";;" "<Esc>mpA;<Esc>`p")
(map! [n] ",," "<Esc>mpA,<Esc>`p")
;; (map! [i] ";;" "<Esc>mpA;<Esc>`p")
;; (map! [i] ",," "<Esc>mpA,<Esc>`p")

;; Keep search terms in middle
(map! [n] "n" "nzzzv")
(map! [n] "N" "Nzzzv")

;; Keep jumping in middle
(map! [n] "<C-u>" "<C-u>zz")
(map! [n] "<C-d>" "<C-d>zz")

;; Join lines without moving cursor
(map! [n] "J" "mzJ`z")

;; Easy insertion of newline at cursor
(map! [n] "<leader><CR>" "a<CR><Esc>")

;; Split window
(map! [n] "ss" ":split<Return><C-w>w")
(map! [n] "sv" ":vsplit<Return><C-w>w")

;; Resize splits
(map! [n :silent] "<Leader>+" ":vertical resize +5<CR>")
(map! [n :silent] "<Leader>-" ":vertical resize -5<CR>")
(map! [n :silent] "<Leader>h+" ":horizontal resize +5<CR>")
(map! [n :silent] "<Leader>h-" ":horizontal resize -5<CR>")

;; Window movement
(map! [n] "<c-h>" "<c-w>h")
(map! [n] "<c-j>" "<c-w>j")
(map! [n] "<c-k>" "<c-w>k")
(map! [n] "<c-l>" "<c-w>l")


;; Quick play macros on the number row
(map! [n] "<F13>" "@1")
(map! [n] "<F14>" "@2")
(map! [n] "<F15>" "@3")
(map! [n] "<F16>" "@4")
(map! [n] "<F17>" "@5")
(map! [n] "<F18>" "@6")
(map! [n] "<F19>" "@7")
(map! [n] "<F20>" "@8")
(map! [n] "<F21>" "@9")

;; Close buffer
(map! [n] "<C-c>" ":bp|bd #<CR>")

;; Allows for moving lines like in vscode
(map! [n] "<A-j>" ":m .+1<CR>==")
(map! [n] "<A-k>" ":m .-2<CR>==")
(map! [i] "<A-j>" "<Esc>:m .+1<CR>==gi")
(map! [i] "<A-k>" "<Esc>:m .-2<CR>==gi")
(map! [v] "<A-j>" ":m '>+1<CR>gv=gv")
(map! [v] "<A-k>" ":m '<-2<CR>gv=gv")
;; For mac
(map! [n] "√" ":m .+1<CR>==")
(map! [n] "ª" ":m .-2<CR>==")
(map! [i] "√" "<Esc>:m .+1<CR>==gi")
(map! [i] "ª" "<Esc>:m .-2<CR>==gi")
(map! [v] "√" ":m '>+1<CR>gv=gv")
(map! [v] "ª" ":m '<-2<CR>gv=gv")

;; cmap w!! %!sudo tee > /dev/null %
(map! [c] "w!!" "%!sudo tee > /dev/null %")
