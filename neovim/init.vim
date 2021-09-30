" ##############################################################################
" #  Bryan Vestey's init.vim file                                                #
" #  Use at your own risk :P                                                   #
" ##############################################################################

" ##############################################################################
" # Setup vim-plug and list the plugins used                                     #
" ##############################################################################

call plug#begin()

" For handling code highliting and knowing the current location information
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Quality code parsing
Plug 'JoosepAlviste/nvim-ts-context-commentstring' " Figuring out comment style

" For auto-complete
Plug 'neovim/nvim-lspconfig' " LSP support
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

" For Snippets.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Theme
Plug 'lifepillar/vim-solarized8'

" Status bar at the bottom
Plug 'vim-airline/vim-airline' " Bottom Bar with information
Plug 'vim-airline/vim-airline-themes' " Theme the bottom bar

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'

" CTRL+P for Vim
Plug 'ctrlpvim/ctrlp.vim'

" Comments
Plug 'tpope/vim-commentary'

" Code Formatting
Plug 'sbdchd/neoformat'

" More go support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

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

" nvim-cmp settings
set completeopt=menu,menuone,noselect

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

-- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      -- For `vsnip` user.
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` user.

      -- For `luasnip` user.
      -- require('luasnip').lsp_expand(args.body)

      -- For `ultisnips` user.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },

    -- For vsnip user.
    { name = 'vsnip' },

    -- For luasnip user.
    -- { name = 'luasnip' },

    -- For ultisnips user.
    -- { name = 'ultisnips' },

    { name = 'buffer' },
  }
})

-- Setup language servers
local cmp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities());
require'lspconfig'.bashls.setup{ capabilities = cmp_capabilities; }
require'lspconfig'.gopls.setup{ capabilities = cmp_capabilities; }
require'lspconfig'.graphql.setup{ capabilities = cmp_capabilities; }
require'lspconfig'.sqlls.setup{
  cmd = {"/usr/local/bin/sql-language-server", "up", "--method", "stdio"};
  capabilities = cmp_capabilities;
}
require'lspconfig'.svelte.setup{ capabilities = cmp_capabilities; }
require'lspconfig'.terraformls.setup{ capabilities = cmp_capabilities; }
require'lspconfig'.tsserver.setup{ capabilities = cmp_capabilities; }
require'lspconfig'.vimls.setup{ capabilities = cmp_capabilities; }
require'lspconfig'.yamlls.setup{ capabilities = cmp_capabilities; }
require'lspconfig'.zeta_note.setup{
  cmd = {'~/bin/zeta-note'};
  capabilities = cmp_capabilities;
}
EOF
