# Setting up the vim environment

This is configured expecting that you will be using NeoVim version 6 or newer

## init.vim file

Make sure that you have your init.vim file symlinked so that you get the correct configuration.

```sh
mkdir ${HOME}/.config/nvim
ln -s ${HOME}/.mydotfiles/neovim/init.vim ${HOME}/.config/nvim/init.vim
```

## Plugins

First things first, you need to install vim-plug to help with handling the
plugins.

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Then open nvim and run `:PlugInstall` to install the plugins.

### List of plugins used

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): Does basic file parsing for language information.
```vim
" Install support for all of the languages
:TSInstall all
```
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring): Figuring out what the correct comment string type is at the given location
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): Using LSPs for auto-complete
```bash
# NPM Installable Language Servers
##################################
npm install -g graphql-language-service-cli sql-language-server svelte-language-server typescript typescript-language-server vim-language-server yaml-language-server

# Terraform Support
###################

# Linux, check for newer versions
curl -o ./terraform-ls.zip https://releases.hashicorp.com/terraform-ls/0.24.0/terraform-ls_0.24.0_linux_amd64.zip
unzip terraform-ls.zip -d ~/.local/bin/
rm terraform-ls.zip

# MacOS
brew install hashicorp/tap/terraform-ls
```

- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp): LSP support for auto-complete.
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer): Buffers for auto-complete.
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): Auto-Complete.
- [cmp-vsnip](https://github.com/hrsh7th/cmp-vsnip): Integrate snippets with auto-complete
- [vim-vsnip](https://github.com/hrsh7th/vim-vsnip): Snippet Support
- [vim-solarized8](https://github.com/lifepillar/vim-solarized8): Theme Vim
- [vim-airline](https://github.com/vim-airline/vim-airline): To have a nice status bar at the bottom
- [vim-airline-themes](https://github.com/vim-airline/vim-airline-themes): Theme the status bar
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator): Add support for connecting navigation between tmux and vim
- [vimux](https://github.com/preservim/vimux): Lets vim interact with tmux.
- [ctrlp](https://github.com/ctrlpvim/ctrlp.vim): Gives Ctrl+p command to vim
- [vim-commentary](https://github.com/tpope/vim-commentary): Context aware commenting.
- [neoformat](https://github.com/sbdchd/neoformat): Code formatting.
- [vim-go](https://github.com/fatih/vim-go): Additional Go language support
```vim
" Install binaries
:GoInstallBinaries
```

## Finishing up

Make sure to build the help tags, in vim run `:helptags ALL`.  Note that you might need to be running
as sudo user to do this.

