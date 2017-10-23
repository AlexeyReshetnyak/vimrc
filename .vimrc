" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible
"

"There is no need for plugins in Vim at all
execute pathogen#infect()

if has("gui_running")
  set guifont=Bitstream\ Vera\ Sans\ Mono\ 16
  set lines=999 columns=999
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

"autocmd FileType python nnoremap <buffer> <F5> :exec '!clear; python' shellescape(@%, 1)<cr>

"nnoremap <buffer> <F5> :exec '!python' shellescape(@%, 1)<cr>

"noremap <F5> :!python %<cr>
"nnoremap <F5> :echo system('python2 "' . expand('%') . '"')<cr>

" Quick run via <F5>
"nnoremap <F5> :call <SID>compile_and_run()<CR>

augroup SPACEVIM_ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)
augroup END

function! s:compile_and_run()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
       exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
       exec "AsyncRun! javac %; time java %<"
    elseif &filetype == 'sh'
       exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
       exec "AsyncRun! python %"
"       exec "AsyncRun! jumpapp -p gnome-terminal -x sh -c 'ls -l; bash'"
    endif
endfunction

"au FocusLost * :wa
"
"What is that?
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }

command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>

au FileType python map <silent> <S-b> Oimport ipdb; ipdb.set_trace(context=10)<esc> :w<CR>

"map <F5> :exe "ConqueTermSplit python -i " . expand("%") <CR>

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

