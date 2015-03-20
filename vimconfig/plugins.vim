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
  Plugin 'tpope/vim-fugitive'

  " Indent guides - particuarly useful for python.
  " Use <leader>ig to toggle them
  Plugin 'nathanaelkane/vim-indent-guides'

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

" Indent guides colors
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#222  ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333 ctermbg=4
let g:indent_guides_guide_size = 2
let g:indent_guides_start_level = 2
"hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=red

" vim:syntax=vim
