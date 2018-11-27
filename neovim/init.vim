set nocompatible

call plug#begin('~/.local/share/nvim/site/autoload/')
Plug '~/.fzf'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'oblitum/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
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
set number
set ruler
set shiftwidth=4
set smartindent
set showcmd
set shortmess+=A
set tabstop=4
set termguicolors
set viminfo+=!

let NERDTreeWinSize=40
let NERDTreeIgnore=['\.pyc$']
nnoremap <F4> :NERDTreeToggle<CR>

nnoremap j gj
nnoremap k gk

" This is for surround.vim to work as expected.
vmap s S

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#rust#racer_binary = '~/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path = '/usr/local/src/rust/src'
let g:deoplete#sources#rust#show_duplicates = 1
let g:LanguageClient_serverCommands = { 'rust': ['~/.cargo/bin/rustup', 'run', '1.29.2', 'rls'] }

nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

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

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --files-with-matches --filename-pattern ""'

function! Fzf_files_with_dev_icons(command)
    let l:fzf_files_options = '--preview "bat --color always --style numbers {2..} | head -'.&lines.'"'
    function! s:edit_devicon_prepended_file(item)
        let l:file_path = a:item[4:-1]
        execute 'silent e' l:file_path
    endfunction
    call fzf#run({
                \ 'source': a:command.' | devicon-lookup',
                \ 'sink':   function('s:edit_devicon_prepended_file'),
                \ 'options': '-m ' . l:fzf_files_options,
                \ 'down':    '40%' })
endfunction
function! Fzf_git_diff_files_with_dev_icons()
    let l:fzf_files_options = '--ansi --preview "sh -c \"(git diff --color=always -- {3..} | sed 1,4d; bat --color always --style numbers {3..}) | head -'.&lines.'\""'
    function! s:edit_devicon_prepended_file_diff(item)
        echom a:item
        let l:file_path = a:item[7:-1]
        echom l:file_path
        let l:first_diff_line_number = system("git diff -U0 ".l:file_path." | rg '^@@.*\+' -o | rg '[0-9]+' -o | head -1")
        execute 'silent e' l:file_path
        execute l:first_diff_line_number
    endfunction
    call fzf#run({
                \ 'source': 'git -c color.status=always status --short --untracked-files=all | devicon-lookup',
                \ 'sink':   function('s:edit_devicon_prepended_file_diff'),
                \ 'options': '-m ' . l:fzf_files_options,
                \ 'down':    '40%' })
endfunction

map <C-p> :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND)<CR>
