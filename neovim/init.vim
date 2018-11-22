set nocompatible

call plug#begin('~/.local/share/nvim/site/autoload/')
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'oblitum/rainbow'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
call plug#end()

:silent! colorscheme gruvbox
let mapleader=","
syntax on

set background=dark
set backspace=indent,eol,start
set backupdir=~/.config/nvim/tmp//
set cursorline
set directory=~/.config/nvim/backup
set expandtab
set foldlevel=1
set foldmethod=indent
set foldnestmax=10
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set nobackup
set nofoldenable
set nowrap
set number
set ruler
set shiftwidth=4
set smartindent
set showcmd
set shortmess+=A
set t_Co=256
set tabstop=4
set viminfo+=!

nnoremap j gj
nnoremap k gk

" This is for surround.vim to work as expected.
vmap s S

let g:rainbow_active=1

let g:gruvbox_invert_indent_guides=1
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
