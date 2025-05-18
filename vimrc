filetype plugin indent on
syntax on
runtime macros/matchit.vim
" -- NETRW ---
let netrw_banner=0
let g:netrw_altv=1
let g:netrw_keepdir=0
let g:netrw_hide=0
let g:netrw_winsize=20
let g:netrw_liststyle=3
let g:netrw_localcopydircmd='cp -r'
let g:netrw_sizestyle="H"
let g:netrw_fastbrowse = 2
let g:netrw_preview = 1
" --- OPTIONS ---
scriptencoding utf-8
let dir = fnamemodify(getcwd(), ':t') . ' - VIM'
set fileencoding=utf-8
set confirm
set nofoldenable
set termguicolors
set linebreak
set nowrap
set clipboard=unnamedplus
set backspace=indent,eol,start
set list
set listchars=tab:│\ ,trail:·
set hidden
set ignorecase smartcase hlsearch incsearch
set path=.,**
set showcmd ruler wildmenu
set wildmode=longest:full:full
set number relativenumber
set shiftround
set smarttab autoindent smartindent
set smartcase
set splitright
set splitbelow
set noswapfile
set undofile
set complete+=d
set tabstop=4 shiftwidth=4 expandtab
set scrolloff=8 sidescrolloff=8
set pumheight=10
set updatetime=300
set redrawtime=10000
set titlestring=%{dir}
set title
" --- KEYMAPPING ---
nnoremap <silent> <F1> <Nop>
nnoremap <silent> Q <Nop>
nnoremap <silent> <Space> <Nop>
let mapleader = " "
let maplocalleader = ","
nnoremap <silent> <leader>n :Lex!<CR>
nnoremap <silent> <leader>w :set wrap! smoothscroll<CR>
nnoremap <silent> <leader>k :nohlsearch<CR>
nnoremap <silent> <leader>Q :bufdo bdelete<CR>
nnoremap <silent> gf :edit <cfile><CR>
vnoremap <silent> < <gv
vnoremap <silent> > >gv
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
vnoremap <silent> p "_dP
nnoremap <silent> <leader>d "_d
nnoremap <silent> <leader>x "_x
nnoremap <silent> ;; <Esc>mpA;<Esc>`p
nnoremap <silent> ,, <Esc>mpA,<Esc>`p
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv
nnoremap <silent> <C-u> <C-u>zz
nnoremap <silent> <C-d> <C-d>zz
nnoremap <silent> J mzJ`z
nnoremap <silent> ss :split<Return><C-w>w
nnoremap <silent> sv :vsplit<Return><C-w>w
nnoremap <silent> <C-Right>  :vertical resize +5<CR>
nnoremap <silent> <C-Left>   :vertical resize -5<CR>
nnoremap <silent> <C-Down>   :horizontal resize +5<CR>
nnoremap <silent> <C-Up>     :horizontal resize -5<CR>
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
"--- COLORS ---
" colorscheme habamax " VIM 8.2 ->
colorscheme desert
hi Normal guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi ModeMsg      ctermbg=green     ctermfg=black cterm=NONE
hi StatusLineNC ctermbg=darkgrey                cterm=bold
hi Visual       ctermbg=lightcyan ctermfg=black cterm=bold
hi NonText guibg=NONE ctermbg=NONE
