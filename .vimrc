set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

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

syntax enable
set ruler

set laststatus=2 "always show the status line
set noshowmode

"set t_Co=16
"set t_Co=256
"let g:solarized_termcolors=256
set background=dark
colorscheme solarized 

let sym_NO = "\u2116"
let sym_arrow = "\u232A"
let sym_branch = "\u2387"

function! ModeStr()
  let l:mode = mode()
  if     mode ==# "n"  | return "NORMAL"
  elseif mode ==# "i"  | return "INSERT"
  elseif mode ==# "R"  | return "REPLACE"
  elseif mode ==# "v"  | return "VISUAL"
  elseif mode ==# "V"  | return "V-LINE"
  elseif mode ==# "^V" | return "V-BLOCK"
  else                 | return l:mode
  endif
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

set statusline= "clear it out for reloads
set statusline+=%1*%F "full file path (truncated to length)
set statusline+=\ %2*%m%r%1* "modified, read-only flags
set statusline+=\ %{ModeStr()}
set statusline+=\ %3*%{sym_branch}
set statusline+=%=%4*\ %L\ lines\ %1* "line count
set statusline+=\ %Y "current syntax
set statusline+=(%{&ff}) "file format
set statusline+=%{sym_arrow}\ %{sym_branch}\ %6.6{FileSize()}
set statusline+=\ L:%3*%04l%1*,C:%3*%04v%1* "cursor line, column
set statusline+=\ (%p%%) "current percentage into the file
hi User1 term=bold cterm=bold ctermfg=black ctermbg=darkblue
hi User2 term=bold cterm=bold ctermfg=gray ctermbg=darkred
hi User3 term=bold cterm=NONE ctermfg=darkgray ctermbg=darkblue
hi User4 term=bold cterm=NONE ctermfg=lightgray ctermbg=blue

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


"Tell vim to remember certain things when we exit
"'10  :  marks will be remembered for up to 10 previously edited files
""100 :  will save up to 100 lines for each register
":20  :  up to 20 lines of command-line history will be remembered
"%    :  saves and restores the buffer list
"n... :  where to save the viminfo files
set viminfo='10,\"1000,:20,%,n~/.viminfo

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Control-O (open files via CtrlP plugin)
let g:ctrlp_map = '<c-o>'
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]\.(git|hg)$',
  \ 'file': '\v\.(exe|so|dll|pyc|pyo)$',
  \ }
