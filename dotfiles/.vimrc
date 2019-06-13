" execute pathogen#infect()
syntax on
filetype plugin indent on

" Shows the line numbers relative to the one the cursor is on,
" the absolute line number is in the status bar.
set relativenumber
set smartindent

" indentation
set autoindent
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set showcmd
set wildmenu
set showmatch
set incsearch
set hlsearch
set history=1000
set undolevels=10000

" no backup files
set nobackup
set nowritebackup
set noswapfile
" Persistent undo across vim sessions
set undofile
set undodir=~/.vim/undo

set hidden

" interface
set mouse=a
set cursorline
set scrolloff=3 "Shows three lines below or above the cursor when scrolling
set ruler
set visualbell
set ttyfast
set laststatus=2

set lazyredraw
set autochdir

" Keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk
inoremap jj <ESC>

" Buffers
" Open last buffer
nmap <C-e> :e#<CR>
" Cycles between buffers
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>
" Goes to definition found in buffers
nmap ; :CtrlPBuffer<CR>
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0
