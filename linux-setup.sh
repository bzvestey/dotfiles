#!/usr/bin/env bash

set -e

echo "========================="
echo "== Installing Packages =="
echo "========================="

sudo pacman -S vim neovim base-devel git cmake zsh
sudo pacman -S wezterm wezterm-shell-integration wezterm-terminfo
sudo pacman -S docker docker-compose docker-scan
sudo pacman -S otf-cascadia-code ttf-cascadia-code woff2-cascadia-code

pamac build asdf-vm
. /opt/asdf-vm/asdf.sh

asdf plugin add golang
asdf install golang latest
asdf global golang latest

asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

asdf plugin add rust
asdf install rust latest
asdf global rust latest

asdf plugin add kubectl
asdf install kubectl latest
asdf global kubectl latest

asdf plugin add kind
asdf install kind latest
asdf global kind latest

asdf plugin add k9s
asdf install k9s latest
asdf global k9s latest

asdf plugin add mage
asdf install mage latest
asdf global mage latest

asdf plugin add zellij
asdf install zellij latest
asdf global zellij latest

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
git config --global user.email "bryan@vestey.dev"
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

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mv $HOME/.zshrc $HOME/.zshrc.pre-personal

echo << "EOF" > .zshrc
# Path to my oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Path to my .zshrc file
source $HOME/.mydotfiles/zsh/zshrc-linux.zsh
EOF

echo "========================"
echo "== Setting up wezterm =="
echo "========================"

ln -s $HOME/.mydotfiles/wezterm/wezterm.lua $HOME/.wezterm.lua

echo "====================="
echo "== Setting up tmux =="
echo "====================="

ln -s $HOME/.mydotfiles/tmux/tmux.conf $HOME/.tmux.conf

echo "======================="
echo "== Setting up Docker =="
echo "======================="

sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

echo "======================="
echo "== Setting up Zellij =="
echo "======================="

ln -s $HOME/.mydotfiles/zellij $HOME/.config/zellij

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

curl -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-x64" --output - | tar -xz -C $HOME/.local/apps
ln -s $HOME/.local/apps/VSCode-linux-x64/bin/code $HOME/.local/bin/code

echo "==========================="
echo "== Post run instructions =="
echo "==========================="

echo 'Open nvim and run ":PlugInstall" to install plugins.'
echo 'Open nvim and run ":TSInstall all" to install treesplitter items.'
echo 'Open nvim and run ":helptags ALL" to update all the help tags'
echo 'Log out and back in to have permissions to interact with docker'
