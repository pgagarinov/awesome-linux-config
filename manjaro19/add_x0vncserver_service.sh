#!/bin/sh
set -e
cat << 'EOF' > ~/.config/systemd/user/x0vncserver.service
[Unit]
Description=Remote desktop service (VNC)

[Service]
Type=simple
# wait for Xorg started by ${USER}
ExecStartPre=/bin/sh -c 'while ! pgrep -U "$USER" Xorg; do sleep 2; done'
#ExecStart=/usr/bin/x0vncserver -rfbauth %h/.vnc/passwd &
# or login with your username & password
ExecStart=/usr/bin/x0vncserver -PAMService=login -PlainUsers=${USER} -SecurityTypes=TLSPlain

[Install]
WantedBy=default.target
EOF