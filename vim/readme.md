# Setting up the vim environment

This is configured expecting that you will be using Vim version 8 or newer

## .vimrc file

Make sure that you have your .vimrc file symlinked so that you get the correct configuration.
```sh
ln -s ${HOME}/.mydotfiles/vim/vimrc ${HOME}/.vimrc
```

## Theming

You need to create the theme folder first
```sh
mkdir -p ~/.vim/pack/themes/opt/
```

### Solarized8

Install to get the Solarized theme
```sh
git clone https://github.com/lifepillar/vim-solarized8.git ~/.vim/pack/themes/opt/solarized8
```


## Plugins

First things first, you need to install Vundle to help with handling the
plugins.

```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

### vim-polyglot

Massive plugin of languages

### vim-go

For Go Lang support you need to pull down the vim go repo, and then check out the correct version

To setup the dependencies of vim-go run the following inside of vim:
```
:GoInstallBinaries
```

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

## Finishing up

Make sure to build the help tags, in vim run `:helptags`.  Note that you might need to be running
as sudo user to do this.

