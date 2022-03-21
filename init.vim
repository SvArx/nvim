"VimPlug for plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'morhetz/gruvbox' "Theming
  Plug 'preservim/nerdtree' "File-explorer 
  Plug 'neoclide/coc.nvim',{'branch':'release'} "autocomplete 
  Plug 'itchyny/lightline.vim' "status-line/tabline
  Plug 'tpope/vim-surround' 
  Plug 'mg979/vim-visual-multi' "multiple cursors
call plug#end()
"-----------------------------------------------------------------------------------------------------
"coc
nmap <silent> gd <Plug>(coc-definition)
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() :"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"-----------------------------------------------------------------------------------------------------
"Thememing" 
colorscheme gruvbox
let g:lightline = {'colorscheme': 'wombat',} "tabline
set background=dark
set laststatus=2
set showmode 
"-----------------------------------------------------------------------------------------------------
"NerdTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
"-----------------------------------------------------------------------------------------------------
"Things that should be default
if (has("termguicolors")) 
  set termguicolors
endif
set autoread 
set clipboard=unnamedplus 
"-----------------------------------------------------------------------------------------------------
"Syntax
syntax on
set showmatch
"-----------------------------------------------------------------------------------------------------
"Lines
set nu rnu
set cursorline
map j gj
map k gk
"-----------------------------------------------------------------------------------------------------
"<tab>
set tabstop=2
set autoindent
set shiftwidth=2
set expandtab
"-----------------------------------------------------------------------------------------------------
"views
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"-----------------------------------------------------------------------------------------------------
"search
set ignorecase
set smartcase
set incsearch
set hlsearch
"-----------------------------------------------------------------------------------------------------
" markdown Preview
function! MD_Preview()
  :call Render_MD_Preview()
  :autocmd BufWrite * :call Render_MD_Preview()
  :! firefox "/tmp/mdPreview.html"
endfunction
function! Render_MD_Preview()
  :! markdown '%:p' > /tmp/mdPreview.html
  :! echo "<meta http-equiv='refresh' content='3' />" >> /tmp/mdPreview.html
endfunction
"German Spellcheck
function! German()
  :set spell
  :set spelllang=de_ch
endfunction
"English Spellcheck
function! English()
  :set spell
  :set spelllang=en_gb
endfunction
