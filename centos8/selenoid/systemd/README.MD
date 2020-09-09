#How install systemd services file

Copy the file to `/etc/systemd/system/`

After that you need to start and enable the service

Run the command with root priviledges
<code>
systemctl start selenoid_head_example.service
</code>

<code>
systemctl enable selenoid_head_example.service
</code>
