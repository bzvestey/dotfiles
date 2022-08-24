# SSH Setup

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
UseKeyChain yes
```
