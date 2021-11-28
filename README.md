# Dem Dot Files
These are the random dot or settings files I use on \*nix based devices.  Some
might be OS specific, or only when I decide to use specific programs (bash/zsh).

## Basics
* Clone this to ~/dev/dotfile
* symlink it to ~/.mydotfiles

## Packages

```sh
pacman -S vim tmux git go cmake nodejs npm python base-devel
```

- Docker
- Terraform
- Dagger
- Kind (Local Kubernetes)

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

## net
* firewall.sh will turn on UFW rules for forcing everything through the VPN
* unfirewall.sh will set sane defaults that do not require the firewall
* resolv.conf is a couple of sane DNS servers if you are worried about DNS leaks
