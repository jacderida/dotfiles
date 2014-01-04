filetype off
call pathogen#infect()
filetype plugin indent on

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

set nocompatible
set nowrap
set nobackup
set ignorecase
set smartindent
set tabstop=2
set shiftwidth=2
set guifont=Monospace
set number
set diffexpr=MyDiff()
set lines=50
set columns=120
set viminfo+=!
syntax on
au FileType gitcommit set tw=72

set t_Co=256
color wombat256mod

autocmd! bufwritepost .vimrc source % "Auto reload vimrc when the file is changed
set autoread "Reloads the file when a change has been made in another editor

set nobackup
set nowritebackup
set noswapfile

set encoding=utf-8
set ruler
set relativenumber
set cursorline
set backspace=indent,eol,start
set laststatus=2
set noshowmode

" Window navigation with ctrl+jkhl
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Powerline stuff
set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim
" In terminal mode, prevent the delay in transitioning from insert mode to
" normal mode.
if ! has('gui_running')
	set ttimeoutlen=10
	augroup FastEscape
		autocmd!
		au InsertEnter * set timeoutlen=0
		au InsertLeave * set timeoutlen=1000
	augroup END
endif
