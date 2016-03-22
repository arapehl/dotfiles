set nocompatible              " be iMproved, required
filetype off                  " required

" Set visual marker at 120 chars
set colorcolumn=120

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'gmarik/Vundle.vim'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'kchmck/vim-coffee-script'

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

set hidden "make sure to preserve undo history when switching buffers
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

" Set ctrlp to ignore files in .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Sets how many lines of history VIM has to remember
set history=700

" Make sure airline appears all the time
set laststatus=2
let g:airline#extensions#tabline#enabled = 1

" Set to auto read when a file is changed from the outside
set autoread

" Configure rubocop
" let g:vimrubocop_config = '~/dotfiles/rubocop.yml'

" Configure syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_ruby_checkers = ['rubocop', 'mri']

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Open up QuickFix window after running Fugitive's Ggrep
autocmd QuickFixCmdPost *grep* cwindow

" Window left, right, down, up
nmap <c-h> <c-w><left>
nmap <c-l> <c-w><right>
nmap <c-j> <c-w><down>
nmap <c-k> <c-w><up>

" Fast save
nmap <leader>w :w!<cr>

" Fast save & exit
nmap <leader>x :x<cr>

" Fast buffer destroy
nmap <leader>d :bd<cr>

"Tagbar
nmap <F8> :TagbarToggle<CR>

" Buffers
map <leader>1 :b1<CR>
map <leader>2 :b2<CR>
map <leader>3 :b3<CR>
map <leader>4 :b4<CR>
map <leader>5 :b5<CR>
map <leader>6 :b6<CR>
map <leader>7 :b7<CR>
map <leader>8 :b8<CR>
map <leader>9 :b9<CR>
map <leader>0 :new<CR>
map <leader>m :bp<CR>
map <leader>. :bn<CR>

" CtrlP
map <leader>, :CtrlP<cr>
map <leader>b :CtrlPBuffer<cr>
map <leader>u :CtrlPMRU<cr>

" Easier start & end of line
noremap H ^
nnoremap L $
vnoremap L $h

" Enable per-project .vimrc
set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

" Powerline font setup
" https://coderwall.com/p/yiot4q/setup-vim-powerline-and-iterm2-on-mac-os-x
let g:airline_powerline_fonts = 1
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
