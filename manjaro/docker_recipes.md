## Change IP range for Docker compose bridges

Please read https://github.com/docker/compose/issues/4336#issuecomment-457326123
The advice is to add
```
{
  "debug" : true,
  "default-address-pools" : [
    {
      "base" : "172.31.0.0/16",
      "size" : 24
    }
  ]
}
```
to /etc/docker/daemon.json and execute `sudo systemctl restart docker`
