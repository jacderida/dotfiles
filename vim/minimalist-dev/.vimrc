set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'airblade/vim-gitgutter'
Plugin 'gmarik/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'oblitum/rainbow'
Plugin 'pearofducks/ansible-vim'
Plugin 'Raimondi/delimitMate'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/NERDTree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-endwise'
Plugin 'vim-airline/vim-airline'
call vundle#end()
filetype plugin indent on

set backspace=indent,eol,start
set nowrap
set nobackup
set ignorecase
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set number
set incsearch
set hlsearch
syntax on
if has("win32")
   " These settings are to get ConEmu and Vim in Git Bash to play nice.
   set term=xterm
   set t_Co=256
   let &t_AB="\e[48;5;%dm"
   let &t_AF="\e[38;5;%dm"
endif
colorscheme gruvbox
let mapleader=","

au FileType puppet setlocal shiftwidth=2 tabstop=2
au FileType json setlocal shiftwidth=2 tabstop=2
au FileType ruby setlocal shiftwidth=2 tabstop=2
au FileType yaml setlocal shiftwidth=2 tabstop=2

" In terminal mode, prevent the delay in transitioning from insert mode to
" normal mode. Not sure how much performance this gains, but doesn't seem
" to do any harm, so I'll leave it in.
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" This is for surround.vim to work as expected.
vmap s S

let NERDTreeWinSize=40
let NERDTreeIgnore=['\.pyc$']
nnoremap <F4> :NERDTreeToggle<CR>

let g:rainbow_active=1

let g:airline_powerline_fonts = 1

let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black

"set viminfo+=!
"set showcmd
"set shortmess+=A
"syntax on
"au FileType gitcommit set tw=72
"au FileType gitcommit colorscheme jellybeans
"set mouse=a
"au BufRead,BufNewFile *.jar,*.war,*.ear,*.sar,*.rar set filetype=zip
"au BufRead,BufNewFile Jenkinsfile set filetype=groovy
"set tags=~/.tags/tags
"
"
"set foldmethod=indent
"set foldnestmax=10
"set nofoldenable
"set foldlevel=1
"
"set term=screen-256color
""set t_Co=256
"colorscheme badwolf
"
"
"autocmd! bufwritepost .vimrc source % "Auto reload vimrc when the file is changed
"set autoread "Reloads the file when a change has been made in another editor
"
"set directory=~/.vim/backup
"set backupdir=~/.vim/tmp//
"
"set encoding=utf-8
"set ruler
"set cursorline
"set laststatus=2
"set noshowmode
"set ttyfast
"set lazyredraw
"
"
"
"nnoremap <Leader>df xP:Tabularize /<C-R>-<CR>
"vnoremap <Leader>df xP:Tabularize /<C-R>-<CR>
"nnoremap <Leader>h :set hlsearch!<CR>
"nnoremap <Leader>s vi{
"nnoremap j gj
"nnoremap k gk
"noremap <space> ;
"vnoremap L g_
"
"nnoremap <F1> :source $MYVIMRC<CR>
"nnoremap <F5> :!mvn test<CR>
"nnoremap <F8> :TagbarToggle<CR>
"imap <C-c> <CR><Esc>O
"
"
""let g:syntastic_always_populate_loc_list = 1
"
"nnoremap <silent> <leader>a :set opfunc=<SID>AckMotion<CR>g@
"xnoremap <silent> <leader>a :<C-U>call <SID>AckMotion(visualmode())<CR>g@
"
"function! s:CopyMotionForType(type)
"    if a:type ==# 'v'
"        silent execute "normal! `<" . a:type . "`>y"
"    elseif a:type ==# 'char'
"        silent execute "normal! `[v`]y"
"    endif
"endfunction
"
"function! s:AckMotion(type) abort
"    let reg_save = @@
"    call s:CopyMotionForType(a:type)
"    execute "normal! :Ack! --literal " . shellescape(@@) . "\<cr>"
"    let @@ = reg_save
"endfunction
"
"" Reselect a block that has just been indented.
"vnoremap < <gv
"vnoremap > >gv

"autocmd FileType gitcommit DiffGitCached | wincmd L | wincmd p
"if &diff
"    colorscheme pyte
"endif
