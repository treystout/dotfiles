set runtimepath+=~/.nvim/plug/
let g:python3_host_prog = '/usr/bin/python'

call plug#begin('~/.nvim/plug')
Plug 'fatih/vim-go'
Plug 'icymind/neosolarized'
Plug 'ervandew/supertab'
Plug 'stamblerre/gocode', {'rtp': 'nvim', 'do': '~/.nvim/plug/gocode/nvim/symlink.sh'}
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', {'build': {'unix': 'make'}}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'iamcco/markdown-preview.vim'
Plug 'posva/vim-vue'
" Python Stuff
Plug 'nvie/vim-flake8'
" JS Stuff
"Plug 'neomake/neomake', { 'on': 'Neomake' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install && npm install -g tern' }
Plug 'carlitux/deoplete-ternjs'
Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdtree'
Plug 'ekalinin/Dockerfile.vim'
call plug#end()

" Enable deoplete on startup
let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 1
let g:tern_request_timeout = 6000
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
let g:deoplete#sources#tss#javascript_support = 1
let g:tsuquyomi_javascript_support = 1
let g:tsuquyomi_auto_open = 1
let g:tsuquyomi_disable_quickfix = 1

set termguicolors
set background=dark
colorscheme NeoSolarized
let g:neosolarized_contrast = "high"
highlight Pmenu guifg=#333333 guibg=#DDDDDD
highlight PmenuSel guifg=#111111 guibg=#FF6600
highlight PmenuSbar guibg=#00FF00
highlight PMenuThumb guibg=#ff0000

" Line Numbers
set number
set numberwidth=4

" Initials turn into a timestamped comment (Thanks to Mark Tozzi)
if !exists("TimeStamp")
  fun TimeStamp()
    return "-- TS (" .  strftime("%d %b %Y %X") . ")"
  endfun
endif
iab TS <C-R>=TimeStamp()<cr>

"Go highlights
let g:go_highlight_build_constraits = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types= 1
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_addtags_transform = "camelcase" "or snakecase

"airline customization
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts=1


"vue stuff
autocmd FileType vue syntax sync fromstart

"ale
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '☢'
let g:ale_sign_warning = '◉'
highlight ALEErrorSign guibg=None guifg=red guisp=bold
highlight ALEWarningSign guibg=None guifg=orange guisp=bold


"NERDTree
nnoremap <silent> <C-P> :NERDTreeToggle<CR>

"formatting
"autocmd FileType go,yaml,javascript,js,vue,html,sql,python setlocal shiftwidth=4 tabstop=4 softtabstop=0 expandtab smarttab
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=0 expandtab smarttab
autocmd FileType go,yaml,javascript,js,vue,html,sql setlocal shiftwidth=2 tabstop=2 softtabstop=0 expandtab smarttab

"line limit
autocmd FileType go,python match ErrorMsg '\%>80v.\+'

" italisize comments for Operator Mono
highlight Comment cterm=italic gui=italic

" fold files automatically if syntax is loaded
"set foldmethod=syntax
"set foldlevel=2
"set foldclose=all
"set foldminlines=5

