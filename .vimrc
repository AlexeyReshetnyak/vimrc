if has("gui_running")
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 18
  set lines=999 columns=81
  winp 468 0
endif

if has("syntax")
  syntax on
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
  set shiftwidth=2
  set softtabstop=2
endif

set nocompatible

nnoremap <C-tab> :bnext<CR>
nnoremap <C-S-tab> :bprev<CR>

nnoremap ; :

set fileencodings=utf-8,cp1251,koi8-r,cp866
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar
set guioptions+=a " For copying in system clipboard and paste in a terminal

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set hlsearch

set wildmode=longest,list

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set expandtab
set tabstop=2

set noerrorbells         " don't beep
set nobackup
set noswapfile

set autowrite
set nowrap

set tw=79
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=grey25
set cursorline
highlight CursorLine ctermbg=0 guibg=grey25

nnoremap j gj
nnoremap k gk

cabbrev m make -j4

map <F7> <Esc>:exec("vimgrep ".expand("<cword>")." ./**/*.py") <Bar> cw<CR>

"autocmd QuickFixCmdPost [^l]* nested cwindow
"autocmd QuickFixCmdPost    l* nested lwindow

command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>

au FileType python map <silent> <F9> Oimport ipdb; ipdb.set_trace(context=10)<esc> :w<CR>

set laststatus=2

vnoremap <silent> <C-k> :s#^#\##<cr>:noh<cr>
vnoremap <silent> <C-u> :s#^\###<cr>:noh<cr>

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

set scrolloff=7 " Keep 3 lines below and above the cursor

"set autochdir

autocmd FileType python setlocal completeopt-=preview

set cm=blowfish2

syntax enable
set background=dark
colorscheme solarized

vmap <C-c> "+yi

"map <C-N> :NERDTreeToggle<CR>
"let NERDTreeQuitOnOpen=1

set guiheadroom=0

nnoremap <F3> "=strftime("%c")<CR>P
inoremap <F3> <C-R>=strftime("%c")<CR>

let g:filebeagle_show_hidden = 1
