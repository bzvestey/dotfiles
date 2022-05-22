# Dem Dot Files
These are the random dot or settings files I use on \*nix based devices.  Some
might be OS specific, or only when I decide to use specific programs (bash/zsh).

## Setup ssh-agent

Create `~/.config/systemd/user/ssh-agent.service` with the following content.
```
[Unit]
Description=SSH key agent

[Service]
Type=simple
Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
ExecStart=/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK

[Install]
WantedBy=default.target
```

Next run the following commands
```sh
systemctl --user enable ssh-agent
systemctl --user start ssh-agent
```

Finally add the following line to `~/.ssh/config`
```sh
AddKeysToAgent  yes
```

## Basics
* Clone this to ~/dev/dotfile
* symlink it to ~/.mydotfiles

## Packages

```sh
pacman -S vim nvim tmux git go cmake base-devel docker docker-compose docker-scan
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
