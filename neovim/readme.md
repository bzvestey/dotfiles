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

### nvim-treesitter

Does basic language items, run the below to install the languages we care about

```vim
:TSInstall all
```

### nvim-ts-context-commentstring

Figuring out what the correct comment string type is at the given location

### nvim-lspconfig

Using LSPs for auto-complete

```bash
npm install -g graphql-language-service-cli sql-language-server svelte-language-server typescript typescript-language-server vim-language-server yaml-language-server

# Look for a newer version probably
curl -o ~/bin/zeta-note-linux --create-dirs -L https://github.com/artempyanykh/zeta-note/releases/download/2021-08-22/zeta-note-linux
chmod u+x ~/bin/zeta-note-linux
```

### vim-polyglot

Massive plugin of languages

### vim-go

For Go Lang support you need to pull down the vim go repo, and then check out the correct version

### vim-airline

To have a nice status bar at the bottom

### vim-tmux-navigator

Add support for connecting navigation between tmux and vim

### vimux

Lets vim interact with tmux

### ctrlp

Gives Ctrl-p command to vim

### YouCompleteMe

Good autocomplete support.  Requires an additional install step found
[here](https://github.com/ycm-core/YouCompleteMe#installation).

```sh
```

### vim-commentary

Context aware commenting.

### neoformat

Code formatting.

## Finishing up

Make sure to build the help tags, in vim run `:helptags`.  Note that you might need to be running
as sudo user to do this.

