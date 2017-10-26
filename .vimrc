"Is it needed in Ubuntu?
runtime! debian.vim

execute pathogen#infect()

if has("gui_running")
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 16
  set lines=999 columns=999
"  set lines=999 columns=80
"?  winp 468 0
  if !(&diff)
    let g:NERDTreeWinSize=35
    autocmd VimEnter * NERDTree | wincmd p
  endif
endif

if &diff
  colorscheme werks 
  set lines=999 columns=999
else
  colorscheme my_desert
endif

function Change_theme_and_line()
  colo my_desert 
  highlight ColorColumn ctermbg=0 guibg=grey25
endfunction

colo my_desert
autocmd! BufEnter,BufNewFile *.txt colo morning
autocmd! BufLeave *.txt call Change_theme_and_line()

if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

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

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)


set nocompatible

nnoremap <C-tab> :bnext<CR>
nnoremap <C-S-tab> :bprev<CR>

nnoremap ; :

set fileencodings=utf-8,cp1251,koi8-r,cp866
:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

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

set tags=./tags,tags;
:se tags+=/home/al/projects/opencv/tags
set autowrite
set nowrap
"command! -nargs=* Wrap set wrap linebreak nolist

let Tlist_Use_Right_Window   = 1

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=grey25
set cursorline
highlight CursorLine ctermbg=0 guibg=grey25

":nmap <silent> <A-k> gk
":nmap <silent> <A-j> gj
":nmap <silent> <k> gk
":nmap <silent> <j> gj
"Experimental !!!! WARNING
nnoremap j gj
nnoremap k gk

"nnoremap <C-b> :make<bar>copen<CR>
"cabbrev m make<bar>copen

cabbrev m make -j4

" grep for word under cursor in c/cpp/h-files
"map <F7> <Esc>:exec("vimgrep ".expand("<cword>")." ./**/*.c ./**/*.h ./**/*.cpp ./**/*.hpp") <Bar> cw<CR>
"map <F7> <Esc>:exec("vimgrep ".expand("<cword>")." ./**/*.c* ./**/*.h*") <Bar> cw<CR>

" Automatically open, but do not go to (if there are errors) the quickfix /
 " location list window, or close it when is has become empty.
 "
 " Note: Must allow nesting of autocmds to enable any customizations for
" quickfix
" " buffers.
" " Note: Normally, :cwindow jumps to the quickfix window if the command opens
" it
" " (but not if it's already open). However, as part of the autocmd, this
" doesn't
" " seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"au FocusLost * :wa
"
"What is that?
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>

au FileType python map <silent> <F9> Oimport ipdb; ipdb.set_trace(context=10)<esc> :w<CR>

set laststatus=2

map <S-E> :E <CR>

map <S-N> :NERDTree <CR>

vnoremap <silent> <C-k> :s#^#\##<cr>:noh<cr>
vnoremap <silent> <C-u> :s#^\###<cr>:noh<cr>
"nmap Ж :
"yank
"nmap Н Y
"nmap з p
"nmap ф a
"nmap щ o
"nmap г u
"nmap З P

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

set wrap

set scrolloff=3 " Keep 3 lines below and above the cursor
set guioptions+=a " For copying in system clipboard and paste in a terminal


augroup SPACEVIM_ASYNCRUN
    autocmd!
"      Automatically open the quickfix window
      autocmd User AsyncRunStart call asyncrun#quickfix_toggle(5, 1)
augroup END

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! make -j4"
    elseif &filetype == 'cpp'
"       exec "AsyncRun! make -j4"
    elseif &filetype == 'sh'
       exec "AsyncRun! bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! python %"
    endif
endfunction

" Quick run via <F5>
nnoremap <C-F5> :call <SID>compile_and_run()<CR>
"nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr><F5>
"nnoremap <buffer> <F5> :exec '!ls'<cr><F5>
"nnoremap <F5> :Start python -i %<cr>
"nnoremap <F5> :Dispatch xterm -hold -e python %<cr>
nnoremap <F5> :!python %<cr>

set autochdir

"augroup myvimrc
"    au!
"    au BufWritePost .vimrc so ~/.vimrc
"augroup END

let g:jedi#popup_on_dot = 0
let g:jedi#documentation_command = "<S-k>"
"let g:jedi#completions_command = "<C-Space>"
let g:jedi#completions_command = "<C-n>"
autocmd FileType python setlocal completeopt-=preview

map <F12> <S-k>
imap <F12> <S-k>
