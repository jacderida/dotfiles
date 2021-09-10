set nocompatible

let mapleader=" "
syntax on

set background=dark
set backspace=indent,eol,start
set backupdir=~/.vim/tmp//
set directory=~/.vim/backup
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
set number relativenumber
set ruler
set shiftwidth=4
set smartindent
set showcmd
set shortmess+=A
set tabstop=4
set viminfo+=!

nnoremap j gj
nnoremap k gk

au FileType gitcommit set tw=100
