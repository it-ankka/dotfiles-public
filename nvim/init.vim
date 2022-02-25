" Personal nvim configuration of Lassi Köykkä
"
"-------------------------------------------------------------
" General settings
"-------------------------------------------------------------

language C
set expandtab
set shiftwidth=4
set tabstop=4
set relativenumber
set number
set hidden
set signcolumn=yes
set termguicolors
set undofile
set title
set ignorecase
set smartcase
set wildmode=longest:full,full
set nowrap
set list
set smartindent
set autoindent
set listchars=tab:\│\ ,eol:↴,trail:·
set mouse=a
set scrolloff=8
set sidescrolloff=8
set nojoinspaces
set splitright
set clipboard=unnamedplus
set confirm
set exrc
set pumheight=10
set cursorline
set fileencoding=utf-8
set backup
set backupdir=~/.local/share/nvim/backup//
set updatetime=300 "Reduce time for highlighting other references
set redrawtime=10000 "Allow more time for loading highlighting in large files

" let g:python3_host_prog = '/usr/local/bin/python3'
"-------------------------------------------------------------
" Keybinds
"-------------------------------------------------------------
noremap <Space> <Nop>
let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim
nmap <leader>vc :edit ~/.config/nvim/coc-settings.json<cr>

nmap <leader>k :nohlsearch<CR>
nmap <leader>Q :bufdo bdelete<cr>

" Switch buffers
nmap <M-Left> :bp<cr>
nmap <M-Right> :bn<cr>
nmap <M-h> :bp<cr>
nmap <M-l> :bn<cr>
nmap ˛ :bp<cr>
nmap ﬁ :bn<cr>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Make Y behave like the other capitals
nnoremap Y y$

" When text is wrapped, move by terminal rows, not lines, unless a count is provided
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Paste replace visual selection without copying it
vnoremap <leader>p "_dP
" Delete without yank
nnoremap <leader>d "_d
nnoremap x "_x

" Easy insertion of a trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" Window movement
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Close buffer
nnoremap <c-c> :bp\|bd #<CR>

" if !exists('g:vscode')
    " Allows for moving lines like in vscode
    nnoremap <A-j> :m .+1<CR>==
    nnoremap <A-k> :m .-2<CR>==
    inoremap <A-j> <Esc>:m .+1<CR>==gi
    inoremap <A-k> <Esc>:m .-2<CR>==gi
    vnoremap <A-j> :m '>+1<CR>gv=gv
    vnoremap <A-k> :m '<-2<CR>gv=gv
    " For mac
    nnoremap √ :m .+1<CR>==
    nnoremap ª :m .-2<CR>==
    inoremap √ <Esc>:m .+1<CR>==gi
    inoremap ª <Esc>:m .-2<CR>==gi
    vnoremap √ :m '>+1<CR>gv=gv
    vnoremap ª :m '<-2<CR>gv=gv
" else 
"     nnoremap <A-j> <Cmd>call VSCodeCallVisual('editor.action.moveLinesDownAction', 1)<CR>
"     nnoremap <A-k> <Cmd>call VSCodeCallVisual('editor.action.moveLinesUpAction', 1)<CR>
"     inoremap <A-j> <Cmd>call VSCodeCallVisual('editor.action.moveLinesDownAction', 1)<CR>
"     inoremap <A-k> <Cmd>call VSCodeCallVisual('editor.action.moveLinesUpAction', 1)<CR>
"     vnoremap <A-j> <Cmd>call VSCodeCallVisual('editor.action.moveLinesDownAction', 1)<CR>
"     vnoremap <A-k> <Cmd>call VSCodeCallVisual('editor.action.moveLinesUpAction', 1)<CR>
" endif
cmap w!! %!sudo tee > /dev/null %

"-------------------------------------------------------------
" Plugins
"-------------------------------------------------------------
" Automatically install vimplug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')
if !exists('g:vscode')
  source ~/.config/nvim/plugins/autopairs.vim
  " source ~/.config/nvim/plugins/airline.vim
  source ~/.config/nvim/plugins/lualine.vim
  source ~/.config/nvim/plugins/blamer.vim
  source ~/.config/nvim/plugins/bufferline.vim
  source ~/.config/nvim/plugins/commentary.vim
  source ~/.config/nvim/plugins/coc.vim
  source ~/.config/nvim/plugins/rust-lang.vim
  source ~/.config/nvim/plugins/nvim-dashboard.vim
  source ~/.config/nvim/plugins/fzf.vim
  source ~/.config/nvim/plugins/fugitive.vim
  " source ~/.config/nvim/plugins/indent-blankline.vim
  source ~/.config/nvim/plugins/vim-gitgutter.vim
  source ~/.config/nvim/plugins/surround.vim
  source ~/.config/nvim/plugins/monokai.vim
  source ~/.config/nvim/plugins/nerdtree.vim
  source ~/.config/nvim/plugins/polyglot.vim
  source ~/.config/nvim/plugins/treesitter.vim
  source ~/.config/nvim/plugins/tagalong.vim
  "LSP
  " source ~/.config/nvim/plugins/nvim-lspconfig.vim
  " source ~/.config/nvim/plugins/lspsaga.vim
endif
" source ~/.config/nvim/lsp/init.lua
" source ~/.config/nvim/plugins/lspsaga.lua
" source ~/.config/nvim/plugins/neoscroll.vim

call plug#end()
doautocmd User PlugLoaded
