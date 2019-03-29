### Customized Pi-Hole image
Differences with the [`pihole/pihole`](https://hub.docker.com/r/pihole/pihole) official image are:
 - Built-in custom [domain names](99-custom_domains.conf).
 - Network **VLAN** configuration. 
---
#### Edit custom domains
You can edit your custom domain names either in persistence or temporary way. The first way persists between rebuilds, while the temporary way just between container reboots.
##### Persistance (prefered way)
Whenever you want to make changes to your custom domain names, you need to update [`99-custom_domains.conf`](99-custom_domains.conf), then rebuild the container with `docker-compose up -d --build`.
##### Temporary
This method changes the file `99-custom_domains.conf` inside the created container, hence all the changes will be lost together with the container deletion.
 - First of all copy the file from the container to the local host:
   `docker container cp pihole:/etc/dnsmasq.d/99-custom_domains.conf /tmp`
 - Edit `/tmp/99-custom_domains.conf` with your favorite text editor.
 - Copy back the updated file to the container:
   `docker container cp /tmp/99-custom_domains.conf pihole:/etc/dnsmasq.d/`
 - Restart the dns service:
   `docker container exec pihole /usr/local/bin/pihole restartdns`

Other options are logging into the container by spawning a shell, edit the file from there, then restart the dns service. But you will need to install a text editor since there are not. The image is based on [`scratch`](https://hub.docker.com/_/scratch). Or, if you have root access on the host system, you can cd into the `etc-dnsmasq.d` docker volume and edit the file from there, then restart the dns service. 
