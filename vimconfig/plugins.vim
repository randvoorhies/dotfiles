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
  "Plugin 'AutomaticLaTeXPlugin'
  Plugin 'LaTeX-Suite-aka-Vim-LaTeX'
  Plugin 'tpope/vim-fugitive'
  Plugin 'hynek/vim-python-pep8-indent'
  Plugin 'tell-k/vim-autopep8'
  Plugin 'gregsexton/MatchTag'

  " Indent guides - particuarly useful for python.
  " Use <leader>ig to toggle them
  Plugin 'nathanaelkane/vim-indent-guides'


  "Plugin 'pyflakes.vim'
  Plugin 'https://github.com/Valloric/YouCompleteMe'
  Plugin 'Syntastic'
  "
  Plugin 'pangloss/vim-javascript'
  Plugin 'indenthtml.vim'

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
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#222 ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333 ctermbg=4
let g:indent_guides_guide_size = 4
let g:indent_guides_start_level = 1

" Syntastic Settings
let g:syntastic_html_checkers = ['jshint']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501'

let g:html_indent_inctags = "html,body,head,tbody"

" YouCompleteMe Settings
let g:ycm_confirm_extra_conf = 0

" vim:syntax=vim
