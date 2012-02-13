set nocompatible

filetype off                   " required!

 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

 " let Vundle manage Vundle
 " required! 
 Bundle 'gmarik/vundle'
 Bundle 'Arduino-syntax-file'
 Bundle 'python.vim'
 Bundle 'pythoncomplete'
 Bundle 'pyflakes.vim'
 Bundle 'LaTeX-Suite-aka-Vim-LaTeX'

filetype plugin indent on     " required! 

syntax on
filetype on
set encoding=utf-8
set autochdir
set ruler
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set expandtab
set showmatch
set guioptions-=T
set showmode                   "Tell me when I'm in insert mode
set ttyfast                    "We're on a fast connection, it's ok to send lots of bytes
set undofile
set undoreload=10000
set showbreak=↪
set fillchars=diff:⣿
set autoread                   "Detect when open files have changed and reopen them
set title
set formatoptions=qn1          "See :help fo-table for options here
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=10
set number

syntax on

"Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>=" 

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='pdflatex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='evince'

autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

" ############################## WILD MENU ##############################
set wildmenu
set wildmode=list:longest
set wildignore+=*.git,*.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png,*.pdf
set wildignore+=*.o
set wildignore+=*.DS_Store
set wildignore+=*.pyc
" ############################## TMP DIRECTORIES ##############################
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup
" ############################## STATUS LINE ##############################
set laststatus=2
set statusline=%f    " Path.
set statusline+=%m   " Modified flag.
set statusline+=%r   " Readonly flag.
set statusline+=%w   " Preview window flag.
set statusline+=\    " Space.
set statusline+=%=   " Right align.

" File format, encoding and type.  Ex: "(unix/utf-8/python)"
set statusline+=(
set statusline+=%{&ff}                        " Format (unix/DOS).
set statusline+=/
set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8).
set statusline+=/
set statusline+=%{&ft}                        " Type (python).
set statusline+=)

" Line and column position and counts.
set statusline+=\ (line\ %l\/%L,\ col\ %03c)

" #########################################################################
" #########################################################################
" Miscellaneous Functions
" #########################################################################
" #########################################################################

" #########################################################################
" OpenOther() - Type ",o" to switch between whatever/include/wherever/myfile.H
"             and whatever/src/wherever/myfile.C
if has('python')
function! OpenOther()
  if expand("%:e") == "C"
    exe "tabe" fnameescape(expand("%:p:r:s?src?include?").".H")
  elseif expand("%:e") == "H"
    exe "tabe" fnameescape(expand("%:p:r:s?include?src?").".C")
  endif
endfunction
nmap ,o :call OpenOther()<CR>
endif

" #########################################################################
" Sprunge() - type :Sprunge to send the selected lines to sprunge.us.
"           The sprunge URL will end up in your clipboard

let os = substitute(system('uname'), "\n", "", "")
if os == "Darwin"
  command! -range=% Sprunge :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us | pbcopy
elseif os == "Linux"
  command! -range=% Sprunge :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us | xcopy 
endif

" #########################################################################
" AlignEq() - type ",=" to align a block of equals signs
if has('python')
python << endpython
def AlignEq():
  import vim
  maxspaces = 0
  for line in vim.current.range:
    maxspaces = max(maxspaces, line.find('='))

  for index, line in enumerate(vim.current.range):
    spaces = line.find('=')
    if spaces == -1: continue
    vim.current.range[index] = line[0:spaces] + ' '*(maxspaces-spaces) + line[spaces:]
endpython
vmap ,= :python AlignEq()<CR>
endif

" #########################################################################
" Setup() - Miscellaneous setup for this vimrc
if has('python')
function! Setup()
python << endpython
import os, vim
HOME = os.environ["HOME"]
# Create the necessary directories for tempfiles, etc
for dirname in ["undodir", "backupdir", "directory"]:
  directory = vim.eval("&"+dirname)
  try: os.makedirs(directory)
  except: pass
endpython
endfunction
autocmd VimEnter * call Setup()
endif
