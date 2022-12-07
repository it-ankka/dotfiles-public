" Personal nvim configuration of Lassi Köykkä
"
"-------------------------------------------------------------
" General settings
"-------------------------------------------------------------

syntax on
set expandtab
set shiftwidth=4
set tabstop=4
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
set inccommand=nosplit
set fileencoding=utf-8
set backup
set linebreak
set backupdir=~/.local/share/nvim/backup//
set updatetime=300 "Reduce time for highlighting other references
set redrawtime=10000 "Allow more time for loading highlighting in large files

" Markdown listchars
au BufNewFile,BufRead *.md set nolist

" SET TITLE
let dir = fnamemodify(getcwd(), ':t') . " - NVIM"
set title
set titlestring=%{dir}

" NEOVIDE
set guifont=Iosevka:18
let g:neovide_transparency=0.9

"-------------------------------------------------------------
" Keybinds
"-------------------------------------------------------------
noremap <F1> <Nop>
noremap <Space> <Nop>
let mapleader = "\<space>"

nmap <leader>ve :edit ~/.config/nvim/init.vim<cr>
nmap <leader>vr :source ~/.config/nvim/init.vim
nmap <leader>vc :edit ~/.config/nvim/coc-settings.json<cr>

nmap <leader>k :nohlsearch<CR>
nmap <leader>Q :bufdo bdelete<cr>

" Toggle linewrap
nnoremap <leader>w :set wrap!<CR>

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

" Smart indent when entering insert mode with i on empty lines
function IndentWithI(default)
    if len(getline('.')) == 0
        return "\"_cc"
    else
        return a:default
    endif
endfunction

" Smart indent when entering insert mode with I on empty lines
nnoremap <expr> I IndentWithI("I")

" Make Y behave like the other capitals
nnoremap Y y$

" When text is wrapped, move by terminal rows, not lines, unless a count is provided
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Paste replace visual selection without copying it
vnoremap p "_dP

" Delete without yank
nnoremap <leader>d "_d
nnoremap x "_x

" Delete word in insertmode
inoremap <M-BS> <C-\><C-o>"_dB

" Easy insertion of a trailing ; or , from insert mode
nmap ;; <Esc>mpA;<Esc>`p
nmap ,, <Esc>mpA,<Esc>`p
" imap ;; <Esc>mpA;<Esc>`p
" imap ,, <Esc>mpA,<Esc>`p

" Easy insertion of newline at cursor
nnoremap <leader><CR> a<CR><Esc>

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w

" Resize splits
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

" Window movement
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l


" Quick play macros on the number row
nnoremap <F13> @1
nnoremap <F14> @2
nnoremap <F15> @3
nnoremap <F16> @4
nnoremap <F17> @5
nnoremap <F18> @6
nnoremap <F19> @7
nnoremap <F20> @8
nnoremap <F21> @9

" Close buffer
nnoremap <c-c> :bp\|bd #<CR>

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

cmap w!! %!sudo tee > /dev/null %

" Terminal settings
autocmd TermOpen,TermEnter * setlocal signcolumn=no nonumber

"-------------------------------------------------------------
" Commands
"-------------------------------------------------------------
command GoRun execute '!cd %:h && go run %'
command GoRunMain execute '!go run main.go'
command VRun execute '!v run %'
command NimRunSilent execute '!nim r --verbosity:0 %'
command NimRun execute '!nim r %'
command TsxRun execute '!tsx %'

function! s:ExecuteInShell(command)
  let command = join(map(split(a:command), 'expand(v:val)'))
  let winnr = bufwinnr('^' . command . '$')
  if winnr > 0
      silent! execute winnr . 'wincmd q'
  endif
  silent! execute 'botright vnew ' . fnameescape(command)
  setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
  echo 'Execute ' . command . '...'
  silent! execute 'silent %!'. command
  silent! execute 'resize '
  silent! execute 'set filetype=html'
  silent! execute 'set wrap'
  silent! execute 'lua vim.diagnostic.disable()'
  silent! execute '1wincmd w'
  silent! redraw
  silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ')'
  silent! execute 'nnoremap <silent> <buffer> <F1> :call <SID>ExecuteInShell(''' . command . ''')<CR>'
  " echo 'Shell command ' . command . ' executed.'
endfunction

command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

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
  source ~/.config/nvim/plugins/auto-session.lua
  source ~/.config/nvim/plugins/autopairs.lua
  source ~/.config/nvim/plugins/blamer.lua
  source ~/.config/nvim/plugins/bufferline.lua
  source ~/.config/nvim/plugins/comment.lua
  source ~/.config/nvim/plugins/fugitive.lua
  source ~/.config/nvim/plugins/fzf-lua.lua
  source ~/.config/nvim/plugins/goyo.vim
  source ~/.config/nvim/plugins/lualine.lua
  source ~/.config/nvim/plugins/markdown-preview.lua
  source ~/.config/nvim/plugins/monokai.lua
  source ~/.config/nvim/plugins/neoformat.lua
  source ~/.config/nvim/plugins/nvim-colorizer.lua
  source ~/.config/nvim/plugins/nvim-lspconfig.lua
  source ~/.config/nvim/plugins/nvim-tree.lua
  source ~/.config/nvim/plugins/polyglot.lua
  source ~/.config/nvim/plugins/surround.lua
  source ~/.config/nvim/plugins/tagalong.lua
  source ~/.config/nvim/plugins/treesitter.lua
  source ~/.config/nvim/plugins/vim-gitgutter.lua

  " DISABLED
  " source ~/.config/nvim/plugins/rust-lang.lua
  " source ~/.config/nvim/plugins/coc.vim
  " source ~/.config/nvim/plugins/copilot.vim
  " source ~/.config/nvim/plugins/fzf.vim
  " source ~/.config/nvim/plugins/indent-blankline.vim
  " source ~/.config/nvim/plugins/nvim-dashboard.lua
  " source ~/.config/nvim/plugins/nvim-lspconfig.lua
endif

call plug#end()
doautocmd User PlugLoaded

" Set correct filetype for vlang
autocmd BufRead,BufNewFile *.v set filetype=vlang

" Set correct filetype for prisma
autocmd BufRead,BufNewFile *.prisma set filetype=prisma

" Commenting in nim files
autocmd FileType nim setlocal commentstring=#\ %s
