set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Valloric/ListToggle'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-rails'
Plugin 'wincent/Command-T'
Plugin 'scrooloose/NERDTree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'rodjek/vim-puppet'
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'sukima/xmledit'
Plugin 'tomasr/molokai'
Plugin 'Keithbsmiley/tmux.vim'
Plugin 'godlygeek/csapprox'
Plugin 'junegunn/seoul256.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'morhetz/gruvbox'
Plugin 'majutsushi/tagbar'
call vundle#end()
filetype plugin indent on

call pathogen#infect()
set nowrap
set nobackup
set ignorecase
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set guifont=Monospace
set number
set lines=50
set columns=120
set viminfo+=!
set showcmd
syntax on
au FileType gitcommit set tw=72
set mouse=a
au BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar set filetype=zip
set tags=~/.tags/tags
let g:indent_guides_guide_size=1

au FileType puppet setlocal shiftwidth=2 tabstop=2
au FileType json setlocal shiftwidth=2 tabstop=2
au FileType ruby setlocal shiftwidth=2 tabstop=2

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

set term=screen-256color
set t_Co=256
colorscheme gruvbox
set background=dark

autocmd! bufwritepost .vimrc source % "Auto reload vimrc when the file is changed
set autoread "Reloads the file when a change has been made in another editor

set directory=~/.vim/backup
set backupdir=~/.vim/tmp//

set encoding=utf-8
set ruler
set cursorline
set backspace=indent,eol,start
set laststatus=2
set noshowmode
set ttyfast
set lazyredraw

set incsearch
set hlsearch

let NERDTreeWinSize=40

let mapleader=","
nnoremap <Leader>g mzgg=G`z<CR> " Indents the file and returns you to the current line
nnoremap <Leader>h :set hlsearch!<CR>
nnoremap <Leader>s vi{
nnoremap j gj
nnoremap k gk
noremap <space> ;
vnoremap L g_
" This is for surround.vim to work as expected. I never used the s command
" anyway.
vmap s S

nnoremap <F2> :!./%<CR> " Execute current shell script
nnoremap <F3> :!sudo ./%<CR> " Execute current shell script as sudo
nnoremap <F4> :NERDTreeToggle<CR>
nnoremap <F5> :!mvn test<CR>
nnoremap <F8> :TagbarToggle<CR>

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

let g:ycm_confirm_extra_conf = 0
let g:syntastic_always_populate_loc_list = 1
let g:ycm_collect_identifiers_from_tags_files = 1

if &diff
    colorscheme pyte
endif
