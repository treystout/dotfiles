" INFECT IT!
execute pathogen#infect()

set nocompatible

set tabstop=2

set softtabstop=2
set shiftwidth=2
set showmatch
"set virtualedit=all
set novisualbell
set noerrorbells
set expandtab

" Line Numbers
set number
set numberwidth=4

filetype plugin indent on

syntax on
set ruler

set laststatus=2 "always show the status line
set noshowmode

let sym_NO = "\u2116"
let sym_arrow = "\u232A"
let sym_branch = "\u2387"

set statusline= "clear it out for reloads
set statusline+=%1*%F "full file path (truncated to length)
set statusline+=\ %2*%m%r%1* "modified, read-only flags
set statusline+=\ %3*%{sym_branch}\ %{fugitive#statusline()}
set statusline+=%=%4*\ %L\ lines\ %1* "line count
set statusline+=\ %Y "current syntax
set statusline+=(%{&ff}) "file format
"set statusline+=%{sym_arrow}\ %{sym_branch}\ %6.6{FileSize()}
set statusline+=\ L:%3*%04l%1*,C:%3*%04v%1* "cursor line, column
set statusline+=\ (%p%%) "current percentage into the file

function! ModeStr()
  let mode = mode()
  let mode_str = 'NORMAL'
  if mode == "v"
    let mode_str = 'VISUAL'
  endif
  return mode_str
endfunction

function! FileSize()
  let bytes = getfsize(expand("%:p"))
  if bytes <= 0
    return ""
  endif
  if bytes < 1024
    return bytes . "B"
  else
    return (bytes / 1024) . "KB"
  endif
endfunction

"colorscheme molokai
set background=dark
colorscheme solarized
se t_Co=16

" Python Stuff
let python_highlight_all=1
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" " Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


" uglify chars past the 80 col limit
au BufWinEnter *.py,*.pyw let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

au BufRead,BufNewFile *.j2 set filetype=htmljinja
au BufRead,BufNewFile *.less set filetype=less

" override some colorscheme directives for our statusline highlights
hi User1 term=bold cterm=bold ctermfg=darkgray ctermbg=darkblue
hi User2 term=bold cterm=bold ctermfg=gray ctermbg=darkred
hi User3 term=bold cterm=NONE ctermfg=lightgray ctermbg=darkblue
hi User4 term=bold cterm=NONE ctermfg=lightgray ctermbg=blue


" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
" set viminfo='10,\"100,:20,%,n~/.viminfo

autocmd BufReadPost *
      \if line("'\"") > 0 && line ("'\"") <= line("$") |
      \exe "normal! g'\"" |
      \endif
