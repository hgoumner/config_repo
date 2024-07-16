"############################################################################################################"
"# Hristo's vimrc settings
"############################################################################################################"

"###########################"
" Vim settings
"###########################"

" auto-reload vimrc-changes
augroup myvimrc
    autocmd!
    autocmd BufWritePost .vimrc,_vimrc,vimrc so $MYVIMRC
augroup END

" use a | cursor in insert mode
let &t_SI = "\<Esc>[5 q"

" use a rectangle cursor otherwise
let &t_EI = "\<Esc>[1 q"

" start vim/gvim maximized
autocmd GUIEnter * simalt ~X

" Set language to english
set langmenu=en_US
let $LANG ='en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Set font
set guifont=MesloLGS_NF:h10

" Show line and column numbers, line endings
set number
set relativenumber
set ruler
set cursorline
set list

" command line completion
set wildmode=longest,list,full
set wildmenu
set wildignore+=*.pyc
set wildignore+=**/.git/*

" Turn on syntax highlighting
syntax on

" do not fold on file load
set nofoldenable

" set encoding to utf8
set encoding=utf-8

" replace tab with 4 spaces
set tabstop=4 shiftwidth=4 expandtab

" allow writing anywhere in buffer
set virtualedit=block

" activate backspace key
set backspace=2

" clipboard and swapfile settings
set clipboard=unnamed                          " < copy/paste to register * (system's copy/paste buffer)
set noswapfile
set dir=~/tmp                                  " store swapfiles in tmp directory

" clear and limit viminfo entries
set viminfo='10,<10,s10

" tag directory
set tags+=tags;$HOME

" set working directory to open file directory
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

" Open Ggrep results in a quickfix window
autocmd QuickFixCmdPost *grep* cwindow

" set Vim leader key
let mapleader = "\<Space>"

" set shortmess for search count
set shortmess-=S

"###########################"
" F key mappings
"###########################"

"###########################"
" Personal
"###########################"

" select all
nnoremap <C-a> ggVG

" select with alt + mouse in column mode
noremap <M-LeftMouse> <LeftMouse><Esc><C-V>

" enter search and replace
noremap ,, :%s///g<Left><Left><Left>
noremap ,. :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" toggle search highlighting
nnoremap <C-k0> :set hlsearch!<CR>

" copy selection
vnoremap <C-c> "+y

" paste selection (from clipboard)
inoremap <C-v> <C-r>+

" delete and send to void register
vnoremap <Del> "_d

" fix indentation of complete file
nnoremap <C-i> gg=G<CR>

" keep search matches and line joining in screen center
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap <kMultiply> *zz
nnoremap <kDivide> #zz
nnoremap # #zz
nnoremap J mzJ`z

" yank to end of line
nnoremap Y y$

" word completion with tab
" inoremap <Tab> <C-n>

" auto-close
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>

" move lines
nnoremap <silent> <A-j>        :m .+1<CR>==
nnoremap <silent> <A-k>        :m .-2<CR>==
inoremap <silent> <A-j>   <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k>   <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j>        :m '>+1<CR>gv=gv
vnoremap <silent> <A-k>        :m '<-2<CR>gv=gv

" navigate in insert and command mode
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-l> <Right>
cnoremap <C-k> <Up>

" toggle through buffers
nnoremap <C-k1> :bp<CR>
nnoremap <C-k2> :buffers<CR>:buffer<Space>
nnoremap <C-k3> :bn<CR>

" ############# leader mappings #############

" open new buffer
nnoremap <leader>bh :leftabove  vnew<CR>
nnoremap <leader>bl :rightbelow vnew<CR>
nnoremap <leader>bk :leftabove  new<CR>
nnoremap <leader>bj :rightbelow new<CR>

" show all open buffers in vertical split
nnoremap <leader>bv :vert sball<CR>

" compile and run C code
nnoremap <leader>c :!gcc % -Wall -o %< && ./%< <CR>

" replace comma with dot or dot with comma
nnoremap <leader>cd :%s/\,/./g<CR>
nnoremap <leader>dc :%s/\./,/g<CR>

" diff of currently opened buffers
nnoremap <leader>d :windo diffthis<CR>
nnoremap <leader>f :windo diffoff<CR>

" diff between current buffer state and state of file on drive (as loaded)
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
nnoremap <leader>dt :DiffOrig<CR>

" remove leading whitespaces
nnoremap <leader>lw :%s/^\s\+//e<CR>

" create new file with leader
nnoremap <leader>n :enew<CR>

" open new file with leader
nnoremap <leader>o :browse confirm e<CR>

" openfoam script
nnoremap <leader>of :source $HOME/vimfiles/scripts/openfoam_case.vim<CR>

" retab
nnoremap <leader>t :retab<CR>

" remove trailing whitespaces
nnoremap <leader>tw :%s/\s\+$//e<CR>


" remove empty lines
nnoremap <leader>. :g/^\h*$/d<CR>

" replace tabs with spaces
nnoremap <leader>ts :%s/\t/    /g<CR>

" set equal buffer size
nnoremap <leader>0 <C-w>=<CR>

" save and close file with leader
nnoremap <leader>e :browse confirm saveas<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>w :w!<CR>
nnoremap <leader>x :x<CR>

"###########################"
" Search settings
"###########################"

"set hlsearch
set incsearch                                                        " highlight search pattern while typing
set ignorecase                                                       " set incremental search
set smartcase                                                        " activate case-insensitive search

" highlight word under cursor with double click
set mouse=a                                                          " Enables mouse click
inoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

"###########################"
" Syntax settings
"###########################"

" ############# FORTRAN / AC2 #############

" Set ac2 as language for input file
autocmd BufNewFile,BufRead,BufReadPost *.iix,*.inp,*.in,*.inp_EXP,*.log,*.dat set
            \ syntax=ac2
            \ filetype=ac2

" Set ac2_out as language for *.out file
autocmd BufNewFile,BufRead,BufReadPost *.out set
            \ syntax=ac2
            \ filetype=ac2_out

" ############# Python #############

autocmd BufNewFile,BufRead,BufReadPost *.py,*.vsz,*.vst set
            \ syntax=python
            \ filetype=python

autocmd BufNewFile,BufRead,BufReadPost *.py,*.vsz,*.vst inoremap<buffer> ' ''<left>
autocmd BufNewFile,BufRead,BufReadPost *.py,*.vsz,*.vst inoremap<buffer> " ""<left>

" ############# DOS Batch #############
autocmd FileType dosbatch inoremap<buffer> % %%<left>

" ############# GMSH #############
autocmd BufNewFile,BufRead,BufReadPost *.geo set
            \ syntax=gmsh
            \ filetype=gmsh

" ############# HTML #############

" ############# C++ #############
"autocmd BufNewFile,BufRead,BufReadPost *.cpp set
"            \ syntax=cpp
"            \ filetype=cpp
"
" ############# OpenFOAM #############

" ############# RELAP5 #############
autocmd BufNewFile,BufRead,BufReadPost *.rl5 set
            \ syntax=relap5
            \ filetype=relap5

" ############# Modelica #############
autocmd BufNewFile,BufRead,BufReadPost *.mo set 
            \ syntax=modelica
            \ filetype=modelica

" ############# All files #############
"autocmd BufReadPre * set nowrap
autocmd BufReadPre * silent! :retab
autocmd BufReadPre * silent! exec "normal gg=G"
autocmd BufRead * silent! set encoding=utf-8

let $PAGER=''
