"-------------------------------------------------------------------------------
"Personal vim config by Sebastian
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Pluged: plugin manager from: https://github.com/junegunn/vim-plug
"-------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

"syntax error highliting
Plug 'scrooloose/syntastic'
"airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"colorscheme tender
Plug 'jacoborus/tender.vim'
"colorscheme gruvbox
Plug 'morhetz/gruvbox'
"You Complete me autocompleteion
Plug 'ycm-core/YouCompleteMe'

call plug#end()

"-------------------------------------------------------------------------------
" General vim settings
"-------------------------------------------------------------------------------

"themeing
set cursorline
set background=dark
colorscheme gruvbox
let g:airline#extensions#tabline#enabled = 1  "sets Airline staus line

set nowrap "line wraps around the the lineend
set tabstop=3
set shiftwidth=3

set nu "turn on line numbering 
set relativenumber "display line number for current line and realtive line number for all the other lines

syntax on "Turn on syntax highlighting.

set hlsearch "highlight all found matches
set incsearch "highlight search while typing
set ignorecase "makes search case insensitve
set smartcase "deactivates case insentive search on capital letter

"autocomplete vim commands
set completeopt=longest,menuone,preview
set wildmenu

" automatically reload file if changed on filesystem
" p> " 'Q' in normal mode enters Ex mode. You almost never want this.:
set autoread
au CursorHold * checktime
set ttyfast "optimizes vim for modern machines 
set noswapfile "blocks creation of swap files 
set undodir=~/.vim/undodir
set undofile
set shortmess+=I "Disable the default Vim startup message.
set noerrorbells visualbell t_vb= "Disable audible bell because it's annoying.
set mouse+=a "Enable mouse support.
set clipboard=unnamedplus "copy to system clipboard

" Try to prevent bad habits.
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

"change backspace key behaivior idk everybody does it I'm blaming group presure.
set backspace=indent,eol,start
"Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

"tabs and tabnavigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


"-------------------------------------------------------------------------------
" Custome functions to easy certain things
"-------------------------------------------------------------------------------

func! SetupOfVim()
	if has('nvim')
		echo 'Setting up nvim'
		let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
		silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
		\ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
		unlet autoload_plug_path
		PlugInstall
		echo 'Finished setting up nvim'
	else
		echo 'vim setup not yet tested might not work'
		let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
		unlet autoload_plug_path
		echo 'finished with vim setup'
	endif
endfunc
