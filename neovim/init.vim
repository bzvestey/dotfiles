" ##############################################################################
" #  Bryan Vestey's init.vim file                                                #
" #  Use at your own risk :P                                                   #
" ##############################################################################

" ##############################################################################
" # Setup vim-plug and list the plugins used                                     #
" ##############################################################################

call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Quality code parsing
Plug 'JoosepAlviste/nvim-ts-context-commentstring' " Figuring out comment style
Plug 'neovim/nvim-lspconfig' " LSP support
Plug 'nvim-lua/completion-nvim' " auto-complete
Plug 'nvim-treesitter/completion-treesitter' " Treesitter based completion options

Plug 'lifepillar/vim-solarized8' " Theme

" Plug 'sheerun/vim-polyglot'
" Plug 'fatih/vim-go.git'
Plug 'vim-airline/vim-airline' " Bottom Bar with information
Plug 'vim-airline/vim-airline-themes' " Theme the bottom bar
Plug 'christoomey/vim-tmux-navigator' " Combine navigation with tmux panes
Plug 'benmills/vimux' " Tmux intergration
Plug 'ctrlpvim/ctrlp.vim' " CTRL+P for Vim
" Plugin 'ycm-core/YouCompleteMe'
Plug 'tpope/vim-commentary' " Comments
Plug 'sbdchd/neoformat' " Code formatting

call plug#end()

" ##############################################################################
" # General Settings Configuration                                             #
" ##############################################################################

" set the leader to space
nnoremap ; :
nnoremap <space> <Nop>
let mapleader = " "

" General
set number	      " Show line numbers
set linebreak	    " Break lines at word (requires Wrap lines)
set showbreak=+++ " Wrap-broken line prefix
set textwidth=100 " Line wrap (number of cols)
set showmatch	    " Highlight matching brace
set spell	        " Enable spell-checking
set visualbell	  " Use visual bell (no beeping)
set showcmd       " Show me what I am typing
set showmode      " Show the current mode

set noswapfile      " Don't use swap file
set nobackup        " Don't create backup files
set nowritebackup
set splitright      " Split vertical windows to the right
set splitbelow      " Split horizontal windows to the bottom
set encoding=utf-8  " Set default encoding to UTF-8
set autowrite       " Automatically save before :next and :make etc.
set autoread        " Automatically reread changed files without asking me
set laststatus=2
set hidden

set hlsearch	    " Highlight all search results
set smartcase	    " Enable smart-case search
set ignorecase	  " Always case-insensitive
set incsearch	    " Searches for strings incrementally

set autoindent	  " Auto-indent new lines
set expandtab	    " Use spaces instead of tabs
set shiftwidth=2  " Number of auto-indent spaces
set smartindent	  " Enable smart-indent
set smarttab	    " Enable smart-tabs
set softtabstop=2 " Number of spaces per Tab
set ts=2          " Number of spaces per tab when opening a file

set backspace=indent,eol,start " Makes backspace more powerful

set confirm	        " Show a Prompt confirmation dialog
set ruler	          " Show row and column ruler information
set cc=81           " Colors the 81st column a different color

set undolevels=1000	            " Number of undo levels

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

" Syntax Highlighting
syntax on

" Setting for use with plugins
filetype plugin indent on " Needed to make plugins work properly

" Understanding that a svelte file is basically HTML, this is only needed when
" not using the vim-svelte plugin
" au! BufNewFile,BufRead *.svelte set ft=html

" ##############################################################################
" # Key Binding Changes                                                        #
" ##############################################################################

" TODO:  Add custom key bindings here!

" Quick tab navigation
map <C-t><up> :tabr<cr>     " Up arrow to go to the first tab
map <C-t><down> :tabl<cr>   " Down arrow to go to the last tab
map <C-t><left> :tabp<cr>   " Left arrow to go to the previous tab
map <C-t><right> :tabn<cr>  " Right arrow to go to the next tab


" ##############################################################################
" # Plugin Settings                                                            #
" ##############################################################################

" solarized8 theme
set background=dark
colorscheme solarized8

" vim-airline
let g:airline_theme='violet'

" vim-go
let g:go_fmt_command = "goimports"
autocmd BufWritePre *.go :GoBuild

" vim-tmux-navigator
let g:tmux_navigator_disable_when_zoomed = 1 " disable navigate away zoom

" NeoFormat auto run
autocmd BufWritePre,InsertLeave *.js Neoformat
autocmd BufWritePre,InsertLeave *.ts Neoformat
autocmd BufWritePre,InsertLeave *.svelte Neoformat

" easy access to vimux commands
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>

" Lua based settings
lua << EOF
-- Treesitter settings
require'nvim-treesitter.configs'.setup {
  -- Conext Commentstring settings
  context_commentstring = {
    enable = true,
    config = {
      go = '// %s'
    }
  }
}

-- Setup language servers
require'lspconfig'.bashls.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.graphql.setup{}
require'lspconfig'.sqlls.setup{
  cmd = {"/usr/local/bin/sql-language-server", "up", "--method", "stdio"};
}
require'lspconfig'.svelte.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.zeta_note.setup{
  cmd = {'path/to/zeta-note'}
}
EOF

" Use completion-nvim in every buffer
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
set shortmess+=c
" let g:completion_chain_complete_list = {
" 			\'default' : {
" 			\	'default' : [
" 			\		{'complete_items' : ['lsp', 'ts', 'snippet']},
" 			\		{'mode' : 'file'}
" 			\	],
" 			\	'comment' : [],
" 			\	'string' : []
" 			\	}
"       \}
autocmd BufEnter * lua require'completion'.on_attach()

