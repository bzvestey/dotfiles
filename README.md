# Dem Dot Files
These are the random dot or settings files I use on \*nix based devices.  Some
might be OS specific, or only when I decide to use specific programs (bash/zsh).

## Basics
* Clone this to ~/dev/dotfile
* symlink it to ~/.mydotfiles

## zsh
* Download zsh
* Download [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* Start zsh at least once (oh-my-zsh should do this for you)
* Update ~/.zshrc to look something like this:
```sh
# Path to my oh-my-zsh installation.
export ZSH=/home/bzvestey/.oh-my-zsh

# Path to my .zshrc file
source ~/.mydotfiles/zsh/zshrc-linux.zsh
```
