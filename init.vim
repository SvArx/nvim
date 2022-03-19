"VimPlug for plugins
call plug#begin('~/.config/nvim/plugged')

  Plug 'morhetz/gruvbox' "Theming
  Plug 'preservim/nerdtree' "File-explorer

call plug#end()

"Thememing
if (has("termguicolors")) 
  set termguicolors
endif

set background=dark
colorscheme gruvbox

"NerdTree mapping
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

set modifiable "allows us to modifiy files in nerdTree

"standart configurations
set nu rnu

set autoindent
set tabstop=2
set shiftwidth=2
set expandtab

set showmatch
syntax on

set ignorecase
set incsearch
set hlsearch

set clipboard=unnamedplus

set showmode

"Tab-navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Custom functions
function! MD_Preview()
  :call Render_MD_Preview()
  :autocmd BufWrite * :call Render_MD_Preview()
  :! firefox "/tmp/mdPreview.html"
endfunction

function! Render_MD_Preview()
  :! markdown '%:p' > /tmp/mdPreview.html
  :! echo "<meta http-equiv='refresh' content='3' />" >> /tmp/mdPreview.html
endfunction

function! German()
  :set spell
  :set spelllang=de_ch
endfunction

function! English()
  :set spell
  :set spelllang=en_gb
endfunction
