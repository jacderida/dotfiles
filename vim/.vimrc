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
set showcmd
syntax on
au FileType gitcommit set tw=72
set mouse=a
au BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar set filetype=zip
set tags=~/.tags/tags

au FileType puppet setlocal shiftwidth=2 tabstop=2
au FileType json setlocal shiftwidth=2 tabstop=2
au FileType ruby setlocal shiftwidth=2 tabstop=2

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

set shellcmdflag=-ic
set term=screen-256color
set t_Co=256
set background=light
color solarized

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
set lazyredraw

set incsearch
set hlsearch

let NERDTreeWinSize=40

let mapleader=","
nnoremap <Leader>g mzgg=G`z<CR> " Indents the file and returns you to the current line
nnoremap <Leader>h :set hlsearch!<CR>
nnoremap <Leader>s vi{
" Window navigation with ctrl+jkhl
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
nnoremap j gj
nnoremap k gk
noremap H ^
noremap L $
noremap <space> ;
vnoremap L g_

nnoremap <F2> :!./%<CR> " Execute current shell script
nnoremap <F3> :!sudo ./%<CR> " Execute current shell script as sudo
nnoremap <F4> :NERDTreeToggle<CR>
nnoremap <F5> :!mvn test<CR>

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

" Toggle between absolute/relative line numbers. It'll also be changed
" automatically when entering and leaving insert mode.
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc
nnoremap <C-n> :call NumberToggle()<CR>
:au FocusLost * :set number
:au FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Stolen from Gary Bernhardt's dotfiles. This makes tab do autocompletion when
" it's appropriate.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
