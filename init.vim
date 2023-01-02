"Dependencies list of everything to get up and running with this config.
" - move this config file into ~/.config/nvim/init.vim
" - Install neovim from your repo
" - Install nodejs from your repo (required for coc)
" - Install vim plug https://github.com/junegunn/vim-plug
" - Run PlugInstall to all the plugins
" - Use CocInstall to install the appropriate Language Servers for your work
"VimPlug for plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'morhetz/gruvbox' "Theming
  Plug 'dracula/vim' "Theming
  Plug 'EdenEast/nightfox.nvim' "Theming
  Plug 'preservim/nerdtree' "File-explorer 
  Plug 'neoclide/coc.nvim',{'branch':'release'} "autocomplete 
  Plug 'itchyny/lightline.vim' "status-line/tabline
  Plug 'tpope/vim-surround' 
  Plug 'mg979/vim-visual-multi' "multiple cursors
  Plug 'airblade/vim-gitgutter' "show git changes toggle with :GitGutterToggle
  Plug 'github/copilot.vim' "let's look what this is all about
  Plug 'lukas-reineke/indent-blankline.nvim' 
call plug#end()
"--------------------------------------------------------------------------------------------------
"coc
nmap <silent> gd <Plug>(coc-definition)
inoremap <silent><expr> <C-Space> pumvisible() ? coc#_select_confirm() :"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"--------------------------------------------------------------------------------------------------
"Thememing" 
colorscheme gruvbox
let g:lightline = {'colorscheme': 'wombat',} "tabline
set laststatus=2
set showmode
"--------------------------------------------------------------------------------------------------
"NerdTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
set updatetime=300
"--------------------------------------------------------------------------------------------------
"Things that should be default
if (has("termguicolors")) 
  set termguicolors
endif
set autoread 
set clipboard=unnamedplus 
set list
"--------------------------------------------------------------------------------------------------
"Syntax
syntax on
set showmatch
"--------------------------------------------------------------------------------------------------
"Lines
set nu rnu
set cursorline
map j gj
map k gk
"--------------------------------------------------------------------------------------------------
"<tab>
set tabstop=2
set autoindent
set shiftwidth=2
set expandtab
"--------------------------------------------------------------------------------------------------
"views
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"--------------------------------------------------------------------------------------------------
"search
set ignorecase
set smartcase
set incsearch
set hlsearch
"--------------------------------------------------------------------------------------------------
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


set notermguicolors
