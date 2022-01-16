"
" Personal nvim configuration of Lassi Köykkä
"
"-------------------------------------------------------------
" General settings
"-------------------------------------------------------------

set expandtab
set shiftwidth=4
set tabstop=4
set relativenumber
set number
set hidden
set signcolumn=yes:2
set termguicolors
set undofile
set title
set ignorecase
set smartcase
set wildmode=longest:full,full
set nowrap
set list
set listchars=tab:▸\ ,trail:·
set mouse=a
set scrolloff=8
set sidescrolloff=8
set nojoinspaces
set splitright
set clipboard=unnamedplus
set confirm
set exrc
set backup
set backupdir=~/.local/share/nvim/backup//
set updatetime=300 "Reduce time for highlighting other references
set redrawtime=10000 "Allow more time for loading highlighting in large files

"-------------------------------------------------------------
" Keybinds
"-------------------------------------------------------------
noremap <Space> <Nop>
let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim

nmap <leader>k :nohlsearch<CR>
nmap <leader>Q :bufdo bdelete<cr>

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
" Easy insertion of a trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

" Allows for moving lines like in vscode
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

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

source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/coc.vim
source ~/.config/nvim/plugins/commentary.vim
source ~/.config/nvim/plugins/surround.vim
source ~/.config/nvim/plugins/monokai.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/polyglot.vim
source ~/.config/nvim/plugins/fzf.vim

call plug#end()
doautocmd User PlugLoaded


