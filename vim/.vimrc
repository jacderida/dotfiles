set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'godlygeek/tabular'
Plugin 'mhinz/vim-signify'
Plugin 'mileszs/ack.vim'
Plugin 'morhetz/gruvbox'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'oblitum/rainbow'
Plugin 'pearofducks/ansible-vim'
Plugin 'Raimondi/delimitMate'
Plugin 'rhysd/committia.vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/NERDTree'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'w0rp/ale'
call vundle#end()

:silent! colorscheme gruvbox
filetype plugin indent on
let mapleader=","
syntax on

set background=dark
set backspace=indent,eol,start
set backupdir=~/.vim/tmp//
set cursorline
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
nnoremap <Leader>df xP:Tabularize /<C-R>-<CR>
vnoremap <Leader>df xP:Tabularize /<C-R>-<CR>
nnoremap <Leader>h :set hlsearch!<CR>
" This is for surround.vim to work as expected.
vmap s S

au FileType gitcommit set tw=72
au FileType json setlocal shiftwidth=2 tabstop=2
au FileType puppet setlocal shiftwidth=2 tabstop=2
au FileType ruby setlocal shiftwidth=2 tabstop=2
au FileType yaml setlocal shiftwidth=2 tabstop=2
au FocusGained * :q!
au BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar set filetype=zip
au BufRead,BufNewFile Jenkinsfile set filetype=groovy

let NERDTreeWinSize=40
let NERDTreeIgnore=['\.pyc$']
nnoremap <F4> :NERDTreeToggle<CR>

let g:ackprg = 'ag --vimgrep'

let g:rainbow_active=1

let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

let g:gruvbox_invert_indent_guides=1
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

if has("win32")
   " These settings are to get ConEmu and Vim in Git Bash to play nice.
   set term=xterm
   set t_Co=256
   let &t_AB="\e[48;5;%dm"
   let &t_AF="\e[38;5;%dm"
endif

" Terminal specific settings.
if ! has('gui_running')
    " Prevent delay in transitioning from insert mode to normal mode.
    " Not sure how much performance this gains, but doesn't seem to do
    " any harm, so I'll leave it in.
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
    " This displays gruvbox correctly in terminal mode.
    :silent exec "!source $HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
endif

