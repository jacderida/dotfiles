set nocompatible

call plug#begin('~/.local/share/nvim/site/autoload/')
Plug 'tpope/vim-surround'
call plug#end()

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
