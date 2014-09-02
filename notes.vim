" Vim syntax file
" Language: Sagar's Notes files
" Maintainer: Sagar Pandya <sagargp@gmail.com>
" Last Change: Fri Aug 22 16:24:02 UTC 2014
" Version: 3

" Insert code highlighting into the doc
" From http://vim.wikia.com/wiki/Different_syntax_highlighting_within_regions_of_a_file
function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
        \ matchgroup='.a:textSnipHl.'
        \ start="'.a:start.'" end="'.a:end.'"
        \ contains=@'.group
endfunction

if exists("b:current_syntax")
  finish
endif

syn case ignore

" General stuff (headings, comments, lists, etc)
syn match heading     "^> .*\n"
syn match comment     "^\s*#.*$"
syn match bullet      "\* \(.*\n\)\@="
syn match subbullet   "+ \(.*\n\)\@="
syn match subpbullet  "+ \(.*\n\)\@="
syn match listNum     "^\s*\d\+\."
syn match listLetter  "^\s*\a\."
syn match hline       "-\{3,}"
syn match label       "^\s*\<\w\+\>:"
syn match refer       "(\(see:\).*)"
syn region shell      start=/\$ / end=/\n\n/
syn match fixme       "\(.*FIXME.*\)\|\(\s+!!!\)"

" Todo list items
syn region itemTodo       contains=refer start=/^\[ \].*/         end=/\n\n\|\n\[\@=/
syn region itemStarted    contains=refer start=/^\[-\].*/         end=/\n\n\|\n\[\@=/
syn region itemDone       contains=refer start=/^\[\(x\|\*\)\].*/ end=/\n\n\|\n\[\@=/
syn region itemDunno      contains=refer start=/^\[?\].*/         end=/\n\n\|\n\[\@=/
syn region itemImportant  contains=refer start=/^\[!\].*/         end=/\n\n\|\n\[\@=/

" Tables
syn match tableHeadingText contained "\(\w\|\d\|\.\|\*\|\s\|?\)\+"
syn match tableRowText     contained "\(\w\|\d\|\.\|\*\|\s\|?\)\+"
syn match tableRow         contains=tableRowText "|.\+|"
syn region tableHeading    contains=tableHeadingText start=/\(|\n\)\@<!\(\s*\)+-\+[+-]\++\n\2|\@=/ end=/\(|\n\)\@<=\(\s*\)+-\+\(+\|-\)\++\n\2|\@=/
syn match tableEnd         "\(|\n\)\@<=\(\s*\)+-\+\(+\|-\)\++"

" Highlighting rules
hi link heading       VisualNOS
hi link comment       Comment
hi link bullet        Special
hi link subbullet     CursorLineNR
hi link subpbullet    Constant
hi link listNum       Identifier
hi link listLetter    Statement
hi link hline         VisualNOS
hi label              gui=bold cterm=bold term=bold
hi refer              gui=underline cterm=underline term=underline
hi link shell         Special
hi link fixme         WarningMsg

hi link itemTodo      Statement
hi link itenStarted   Special
hi link itemDone      NonText
hi link itemDunno     Function
hi link itemImportant WarningMsg

hi link tableHeadingText   Identifier
hi link tableRowText       Statement
hi tableHeading            gui=bold
hi tableRow                gui=bold
hi tableEnd                gui=bold

call TextEnableCodeSnip("basic",  ":::",       ":::", "SpecialComment")
call TextEnableCodeSnip("c",      ":::c",      ":::", "SpecialComment")
call TextEnableCodeSnip("cpp",    ":::c++",    ":::", "SpecialComment")
call TextEnableCodeSnip("python", ":::python", ":::", "SpecialComment")

let b:current_syntax="notes"
