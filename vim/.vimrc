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
