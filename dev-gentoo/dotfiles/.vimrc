
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
call plug#end()


set path=.,,**
set number

set background=dark
set termguicolors
colorscheme material-monokai
let g:materialmonokai_italic=1
let g:airline_theme='materialmonokai'

