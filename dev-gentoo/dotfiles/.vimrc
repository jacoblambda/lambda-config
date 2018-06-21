
" Check if Vim-Plug is installed and install it if not
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Initialise Vim-Plug
call plug#begin('~/.vim/plugins')
Plug 'skielbasa/vim-material-monokai'
Plug 'vim-airline/vim-airline'
Plug 'lervag/vimtex'
call plug#end()

silent !mkdir $HOME/.vim/swapfiles// > /dev/null 2>&1
set directory=$HOME/.vim/swapfiles//
silent !mkdir $HOME/.vim/backups// > /dev/null 2>&1
set backupdir=$HOME/.vim/backups//

set path=.,,**
set number

set background=dark
set termguicolors
colorscheme material-monokai
let g:materialmonokai_italic=1
let g:airline_theme='materialmonokai'

set tabstop=4
set shiftwidth=4
set expandtab

set splitbelow
set splitright

autocmd BufEnter *.tpp :setlocal filetype=cpp

