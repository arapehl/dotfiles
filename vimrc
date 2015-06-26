set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'bling/vim-airline'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-fugitive'
Plugin 'hallison/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set cursorline
set t_Co=256
syntax on
set background=dark
colorscheme distinguished

set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

" Turn off swap files
set noswapfile

" Sets the shell bin and rcfile
set shell=/bin/bash\ --rcfile\ ~/.bash_profile\ -i

" Set a var to check when building the bash prompt in order to 
" notify whether or not bash is running under vim or not
let $UNDER_VIM="yes"

" Sets how many lines of history VIM has to remember
set history=700

" Make sure airline appears all the time
set laststatus=2

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast save
nmap <leader>w :w!<cr>

" Fast save & exit
nmap <leader>x :x<cr>

" Fast quit
nmap <leader>q :q<cr>

nmap <leader>ggt :GitGutterLineHighlightsToggle<CR>

" Tabs
map <leader>1 :tabn 1<CR>
map <leader>2 :tabn 2<CR>
map <leader>3 :tabn 3<CR>
map <leader>4 :tabn 4<CR>
map <leader>5 :tabn 5<CR>
map <leader>6 :tabn 6<CR>
map <leader>7 :tabn 7<CR>
map <leader>8 :tabn 8<CR>
map <leader>9 :tabn 9<CR>
map <leader>0 :tabnew<CR>
map <leader>[ :tabp<CR>
map <leader>] :tabn<CR>

" CtrlP
map <leader>, :CtrlP<cr>

" Easier start & end of line
noremap H ^
nnoremap L $
vnoremap L $h

" Enable per-project .vimrc
set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files
