#!/usr/bin/env bash

set -e

echo "========================="
echo "== Installing Packages =="
echo "========================="

sudo pacman -S vim neovim tmux git go cmake base-devel docker docker-compose docker-scan kitty rust

echo "========================"
echo "== Making Directories =="
echo "========================"

mkdir -p $HOME/.ssh
mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/apps
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/systemd/user

echo "=========================="
echo "== Symlinking Dot Files =="
echo "=========================="

ln -s $HOME/dev/dotfiles $HOME/.mydotfiles

echo "===================="
echo "== Setting up git =="
echo "===================="

git config --global init.defaultBranch main
git config --global user.email bryan@vestey.dev
git config --global user.name "Bryan Vestey"

echo "===================="
echo "== Setting up ssh =="
echo "===================="

ln -s $HOME/.mydotfiles/ssh/config $HOME/.ssh/config
ln -s $HOME/.mydotfiles/ssh/ssh-agent.service $HOME/.config/systemd/user/ssh-agent.service
systemctl --user enable ssh-agent
systemctl --user start ssh-agent

echo "===================="
echo "== Setting up zsh =="
echo "===================="

mv $HOME/.zshrc $HOME/.zshrc.pre-personal

echo << "EOF" > .zshrc
# Path to my oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Path to my .zshrc file
source $HOME/.mydotfiles/zsh/zshrc-linux.zsh
EOF

echo "====================="
echo "== Setting up Node =="
echo "====================="

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install node

echo "====================="
echo "== Setting up tmux =="
echo "====================="

ln -s $HOME/.mydotfiles/tmux/tmux.conf $HOME/.tmux.conf

echo "======================="
echo "== Setting up NeoVIM =="
echo "======================="

ln -s $HOME/.mydotfiles/neovim/init.vim $HOME/.config/nvim/init.vim

# Install vim-plug as a plugin manager
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install language servers
npm install -g graphql-language-service-cli sql-language-server svelte-language-server typescript typescript-language-server vim-language-server yaml-language-server

echo "======================="
echo "== Setting up VSCode =="
echo "======================="

curl -L https://code.visualstudio.com/sha/download?build=stable&os=linux-x64 --output - | tar -xz -C $HOME/Documents
ln -s $HOME/.local/apps/VSCode-linux-x64/bin/code $HOME/.local/bin/code

echo "==========================="
echo "== Post run instructions =="
echo "==========================="

echo 'Open nvim and run ":PlugInstall" to install plugins.'
echo 'Open nvim and run ":TSInstall all" to install treesplitter items.'
echo 'Open nvim and run ":helptags ALL" to update all the help tags'