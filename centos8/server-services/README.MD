# How to set parametrized service for ssh

To use this service make sure you have installed `autossh` and `fuser`.
Also user `autotunnel` sould be added on both sides (server and client) and created a ssh-key for no password authorization

>Don't forget to change `<your-server-ip>` to your server ip

<code>
[Unit]

Description= Auto ssh revers tunnel on cindy on port %I

After=network-online.target

[Service]

Restart=always

RuntimeMaxSec=86400

Environment="AUTOSSH_GATETIME=0"

User=autotunnel

WorkingDirectory=/home/autotunnel

ExecStartPre=/usr/bin/autossh -M 0 '`<your-server-ip>`' 'sudo fuser -k %i/tcp || true'

ExecStart=/usr/bin/autossh -M 0 '`<your-server-ip>`' -o "ServerAliveInterval 10" -o "ServerAliveCountMax 3" -p 22 -NR %i:localhost:%i

ExecStop=/usr/bin/fuser -k %i/tcp || true

[Install]

WantedBy=multi-user.target
</code>

Copy the autossh-port@.service to `/etc/systemd/system/`

## Enable and start service on certain port

This example is based on port 8080

These commands need to be runned with root priviledges
<code>
systemctl start autossh-port@8080.service

systemctl enable autossh-port@8080.service
</code>

