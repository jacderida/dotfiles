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
set tabstop=4
set shiftwidth=4
set expandtab
set guifont=Monospace
set number
set diffexpr=MyDiff()
set lines=50
set columns=120
set viminfo+=!
syntax on
au FileType gitcommit set tw=72

set term=screen-256color-bce
let g:solarized_termcolors=256
set t_Co=256
set background=light
colorscheme solarized

autocmd! bufwritepost .vimrc source % "Auto reload vimrc when the file is changed
set autoread "Reloads the file when a change has been made in another editor

set directory=~/.vim/backup
set backupdir=~/.vim/tmp//

set encoding=utf-8
set ruler
set relativenumber
set cursorline
set backspace=indent,eol,start
set laststatus=2
set noshowmode
set ttyfast

set incsearch
set hlsearch

let mapleader=","
nnoremap <Leader>g mzgg=G`z<CR> " Indents the file and returns you to the current line
nnoremap <Leader>h :set hlsearch!<CR>
" Window navigation with ctrl+jkhl
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
" Resize windows with the arrow keys
noremap <up> :set lines-=5<CR>
noremap <down> :set lines+=5<CR>
noremap <left> :set columns-=5<CR>
noremap <right> :set columns+=5<CR>
nnoremap j gj
nnoremap k gk

" Execute shell scripts from within Vim
nnoremap <F2> :!./%<CR>
nnoremap <F3> :!sudo ./%<CR>

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
