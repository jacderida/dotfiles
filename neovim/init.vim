set nocompatible
call plug#begin('~/.local/share/nvim/site/autoload/')
Plug '~/.fzf'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'luochen1990/rainbow'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/echodoc.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'
call plug#end()

:silent! colorscheme gruvbox
let mapleader=" "
syntax on

set background=dark
set backspace=indent,eol,start
set backupdir=~/.config/nvim/tmp//
set clipboard=unnamedplus
set completeopt-=preview
set cursorline
set directory=~/.config/nvim/backup
set expandtab
set foldlevel=1
set foldmethod=indent
set foldnestmax=10
set hidden
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
set shortmess+=c
set tabstop=4
set termguicolors
set updatetime=300
set viminfo+=!

nnoremap j gj
nnoremap k gk

" This is for surround.vim to work as expected.
vmap s S

let g:rainbow_active = 1

let g:gruvbox_invert_indent_guides = 1
let g:indent_guides_guide_size = 1
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
au BufRead,BufNewFile Dockerfile.* set filetype=dockerfile

autocmd VimEnter *
\ command! -bang -nargs=* Ag
\ call fzf#vim#ag(<q-args>, '', { 'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all' }, <bang>0)

" Do an :Ag search for the highlighted word.
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

" Remove the item from the quickfix list with 'dd'.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction
:command! RemoveQFItem :call RemoveQFItem()

" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --files-with-matches --filename-pattern ""'
nmap <silent> <C-P> :Files<CR>

command! -nargs=0 Prettier :CocCommand prettier.formatFile
nmap <leader>gd  <Plug>(coc-definition)
nmap <leader>gr  <Plug>(coc-references)
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
