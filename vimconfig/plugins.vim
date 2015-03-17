if has("user_commands")
  set rtp+=~/.vim/bundle/vundle/
  runtime autoload/vundle.vim
endif
if exists("*vundle#rc")
  " $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  filetype off " required!

  call vundle#rc()

  Plugin 'gmarik/vundle'

  Plugin 'flazz/vim-colorschemes'
  Plugin 'Tabular'
  Plugin 'Arduino-syntax-file'
  Plugin 'https://github.com/randvoorhies/vim-multimarkdown'
  Plugin 'bash-support.vim'
  Plugin 'https://github.com/jansenm/vim-cmake'
  Plugin 'AutomaticLaTeXPlugin'

  "Plugin 'pyflakes.vim'
  "Plugin 'https://github.com/Valloric/YouCompleteMe'
  "Plugin 'Syntastic'

endif
filetype plugin indent on     " required! 

" Tabularize shortcuts
nnoremap <localleader>a= :Tabularize /=<cr>
nnoremap <localleader>a: :Tabularize /:<cr>
nnoremap <localleader>a, :Tabularize /,\zs<cr>
nnoremap <localleader>a; :Tabularize /;\zs<cr>
nnoremap <localleader>a\ :Tabularize /\\<cr>
nnoremap <localleader>a{ :Tabularize /{<cr>
nnoremap <localleader>a} :Tabularize /}<cr>

" Latex Settings
let g:tex_flavor='pdflatex'
let g:Tex_DefaultTargetFormat='pdf'

" vim:syntax=vim
