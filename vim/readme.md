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

### vim-polyglot

Massive plugin of languages

```sh
git clone https://github.com/sheerun/vim-polyglot ~/.vim/pack/plugins/start/vim-polyglot
cd  ~/.vim/pack/plugins/start/vim-polyglot
git checkout v4.2.1 # At the time of writing v4.2.1 was the latest.
```

### vim-go

For Go Lang support you need to pull down the vim go repo, and then check out the correct version

```sh
git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
cd ~/.vim/pack/plugins/start/vim-go
git checkout v1.22 # At the time of writing v1.22 was the latest.
```

### vim-airline

To have a nice status bar at the bottom

```sh
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/plugins/start/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/pack/plugins/start/vim-airline-themes
```

### vim-tmux-navigator

Add support for connecting navigation between tmux and vim
```sh
git clone https://github.com/christoomey/vim-tmux-navigator.git ~/.vim/pack/plugins/start/vim-tmux-navigator
```

### vimux

Lets vim interact with tmux

```sh
git clone https://github.com/benmills/vimux.git ~/.vim/pack/plugins/start/vimux
```

### ctrlp

Gives Ctrl-p command to vim

```sh
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/pack/plugins/start/ctrlp.vim
```

## Finishing up

Make sure to build the help tags, in vim run `:helptags`.  Note that you might need to be running
as sudo user to do this.

