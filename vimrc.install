" Set up vundle and plugins
" Install Vundle with: git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

filetype off " necessary for Vundle

set rtp+=~/.vim/bundle/vundle/
runtime autoload/vundle.vim

call vundle#rc()
" required for vundle
Bundle 'pathogen.vim'
" Vundle itself
Bundle 'gmarik/vundle'
" Explore the filesystem in a tree
Bundle 'scrooloose/nerdtree'
" Persist the NERD tree across tabs
Bundle 'jistr/vim-nerdtree-tabs' 
" Browse tags in a split
Bundle 'Tagbar'
" Style the status line
Bundle 'bling/vim-airline'
" Align text on = or : easily
Bundle 'godlygeek/tabular'
" Fast filesystem nav for projects
Bundle 'ctrlp.vim'
" Show marks in the gutter
Bundle 'ShowMarks7'
" Jump around easily with <leader><leader>cmd
Bundle 'EasyMotion'
" Color theme
Bundle 'chriskempson/vim-tomorrow-theme'
Bundle 'w0ng/vim-hybrid'
Bundle 'chriskempson/base16-vim'
" Git integration
Bundle 'airblade/vim-gitgutter'

let NERDTreeIgnore=['\.o$', '\~$', '\.pyc$']
nnoremap <leader>G :GitGutterLineHighlightsToggle<CR>

" Basic Vim settings
filetype plugin indent on
syntax on                                        " syntax highlighting
let mapleader=","                                " Maps <leader> to ,
colorscheme hybrid
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$' " Highlight VCS conflict markers
set nocompatible                                 " I don't need Vim to be Vi compatible
set mouse=a                                      " Mouse support in terminal Vim
set encoding=utf-8                               " Text encoding should support more than ASCII
set autochdir                                    " Set cwd to the current file's dir
set ruler                                        " Show line, col, line% in bottom right corner
set autoindent                                   " Auto indent new lines
set smartindent                                  " Indent smartly after {'s, etc
set expandtab                                    " Spaces instead of tabs
set tabstop=2                                    " Cols per tab
set shiftwidth=2                                 " Cols per shift (>> and <<)
set showmatch                                    " Briefly show the matching bracket when you type it (won't scroll)
set guioptions-=T                                " No toolbar
set guioptions-=M                                " No menu bar
set guioptions-=l                                " No left scrollbar
set guioptions-=L                                " 
set guioptions-=R                                " No right scrollbar
set guioptions-=r                                " 
set showmode                                     " Tell me when I'm in insert mode
set ttyfast                                      " We're on a fast connection, it's ok to send lots of bytes
set autoread                                     " Detect when open files have changed and reopen them
set title                                        " Set the title bar
set formatoptions=qn1                            " See :help fo-table for options here
set number                                       " Line numbers
set diffopt+=iwhite                              " Ignore whitespace in diffs
set nobackup                                     " Backup off, since most stuff is in SVN, git et.c anyway...
set nowritebackup                                "  
set noswapfile                                   "  
set backspace=indent,eol,start                   " Allow backspace before insertion point
set switchbuf=usetab,newtab                      " Switch to an existing tab if a buffer is open, or create a new one if not
set hidden                                       " Don't unload buffer when it is abandoned
set hlsearch                                     " Highlight all search matches
set incsearch                                    " Indicate next search match as the pattern is being entered
set ignorecase                                   " Ignore case when searching
set smartcase                                    " Do not ignore case when the search pattern contains upper case
set magic                                        " Magic
set tags=./tags,tags;/                           " Look for tag files recursively up to the root directory.
set t_ut=                                        " Redraw background
set nospell                                      " I don't want spell checking

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" ------------
" Mappings
" ------------

" Buffer stuff. Q=go to last buffer; <leader>x=close buffer
nmap Q :b#<CR>
nmap <leader>x :bd<CR>

" jump wrapped lines
nmap j gj
nmap k gk

" jk gets you into normal mode
inoremap jk <esc>

" Edit/source vimrc file in a split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Clear search highlights
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Disable F1
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Toggle line wrap
nnoremap <leader>w :set wrap!<cr>

" ctags stuff
" Jump to a tag definition in a new tab with Ctrl+\
map <C-\> :tab split<cr>:exec("tag ".expand("<cword>"))<CR>

" --------------------
" Misc plugin settings
" --------------------
set completeopt-=preview                                                        " ???
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"  " Only show marks set to these registers
let g:airline#extensions#tabline#enabled=1                                      " Enable airline by default on new sessions
set laststatus=2                                                                " see above

nnoremap <leader>n :NERDTreeTabsToggle<CR>
nnoremap <leader>t :TagbarToggle<CR>
imap <leader>= :Tab /=<CR>
nmap <leader>= :Tab /=<CR>
vmap <leader>= :Tab /=<CR>
imap <leader>: :Tab /:<CR>
nmap <leader>: :Tab /:<CR>
vmap <leader>: :Tab /:<CR>

" -----------------
" Filetype settings
" -----------------

" my notes files
au BufRead,BufNewFile *.note set filetype=notes

" arduino files
au BufRead, BufNewFile *.ino set filetype=arduino

" markdown
au BufRead,BufNewFile *.md set filetype=markdown

" makefiles
augroup filetype_make
  autocmd!
  " Don't expand tabs when editing makefiles
  autocmd! FileType make setlocal noexpandtab
augroup END

" vim scripts
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType vim set foldlevelstart=0
augroup END
 
" text files
augroup filetype_txt
  autocmd BufNewFile,BufRead *.txt setlocal ft=none
  autocmd BufNewFile,BufRead *.txt setlocal spell
  autocmd BufNewFile,BufRead *.txt setlocal foldmethod=marker
augroup END
