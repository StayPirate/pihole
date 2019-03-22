### Custom domains resolution
Whenever you want to update custom domains, make sure you do it within the **etc-dnsmasq.d** volume.
###### First deployment
If it is the first deploy, after you create the container and the volumes (``docker-compose up -d``), copy the preconfigured file: ``docker container cp 99-custom_domains.conf pihole:/etc/dnsmasq.d/`` in the right volume.
___
###### Service restart
Then, don't forget to restart the DNS service with ``docker container exec pihole /usr/local/bin/pihole restartdns`` every time you make a change. Even after the above ``cp``.
