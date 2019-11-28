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

You need to create the plugins folder first
```sh
mkdir -p ~/.vim/pack/plugins/start
```

### vim-go

For Go Lang support you need to pull down the vim go repo, and then check out the correct version

```sh
git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
cd ~/.vim/pack/plugins/start/vim-go
git checkout v1.21 # At the time of writing v1.19 was the latest.
```

### vim-airline

To have a nice status bar at the bottom

```sh
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/plugins/start/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/pack/plugins/start/vim-airline-themes
```

### vim-graphql

Add GraphQL syntax highlighting to GraphQL files, and JavaScript string literals (when using
supported plugins)

```
git clone https://github.com/jparise/vim-graphql.git ~/.vim/pack/plugins/start/vim-graphql
cd ~/.vim/pack/plugins/start/vim-graphql
git checkout 1.1 # At the time of writing this v1.1 was the latest.
```

### vim-tmux-navigator

Add support for connecting navigation between tmux and vim
```
git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.vim/pack/plugins/start/vim-tmux-navigator
```

### vimux

Lets vim interact with tmux
```
git clone https://github.com/benmills/vimux.git ~/.vim/pack/plugins/start/vimux
```

### ctrlp

Gives Ctrl-p command to vim
```
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/pack/plugins/start/ctrlp.vim
```

## Finishing up

Make sure to build the help tags, in vim run `:helptags`.  Note that you might need to be running
as sudo user to do this.

