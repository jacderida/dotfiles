set nocompatible

call plug#begin('~/.local/share/nvim/site/autoload/')
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'oblitum/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
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
set tabstop=4
set viminfo+=!

let NERDTreeWinSize=40
let NERDTreeIgnore=['\.pyc$']
nnoremap <F4> :NERDTreeToggle<CR>

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

au FileType gitcommit set tw=72
au FileType json setlocal shiftwidth=2 tabstop=2
au FileType puppet setlocal shiftwidth=2 tabstop=2
au FileType ruby setlocal shiftwidth=2 tabstop=2
au FileType yaml setlocal shiftwidth=2 tabstop=2
au BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar set filetype=zip
au BufRead,BufNewFile Jenkinsfile set filetype=groovy

" Copy/paste to/from clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
