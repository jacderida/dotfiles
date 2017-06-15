set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
call vundle#end()
filetype plugin indent on

"set nowrap
"set nobackup
"set ignorecase
"set smartindent
"set tabstop=4
"set shiftwidth=4
"set expandtab
"set number
"set relativenumber
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
"let mapleader=","
"let g:indent_guides_guide_size=1
"let g:rainbow_active=1
"
"au FileType puppet setlocal shiftwidth=2 tabstop=2
"au FileType json setlocal shiftwidth=2 tabstop=2
"au FileType ruby setlocal shiftwidth=2 tabstop=2
"au FileType yaml setlocal shiftwidth=2 tabstop=2
"
"set foldmethod=indent
"set foldnestmax=10
"set nofoldenable
"set foldlevel=1
"
"set term=screen-256color
""set t_Co=256
"colorscheme badwolf
"let g:airline_powerline_fonts = 1
"
"let g:indent_guides_auto_colors = 0
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=black
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black
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
"set backspace=indent,eol,start
"set laststatus=2
"set noshowmode
"set ttyfast
"set lazyredraw
"
"set incsearch
"set hlsearch
"
"let NERDTreeWinSize=40
"let NERDTreeIgnore=['\.pyc$']
"
"nnoremap <Leader>df xP:Tabularize /<C-R>-<CR>
"vnoremap <Leader>df xP:Tabularize /<C-R>-<CR>
"nnoremap <Leader>h :set hlsearch!<CR>
"nnoremap <Leader>s vi{
"nnoremap j gj
"nnoremap k gk
"noremap <space> ;
"vnoremap L g_
"" This is for surround.vim to work as expected. I never used the s command
"" anyway.
"vmap s S
"
"nnoremap <F1> :source $MYVIMRC<CR>
"nnoremap <F4> :NERDTreeToggle<CR>
"nnoremap <F5> :!mvn test<CR>
"nnoremap <F8> :TagbarToggle<CR>
"imap <C-c> <CR><Esc>O
"
"" In terminal mode, prevent the delay in transitioning from insert mode to
"" normal mode.
"if ! has('gui_running')
"    set ttimeoutlen=10
"    augroup FastEscape
"        autocmd!
"        au InsertEnter * set timeoutlen=0
"        au InsertLeave * set timeoutlen=1000
"    augroup END
"endif
"
"nnoremap <Leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_autoclose_preview_window_after_completion = 1
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
