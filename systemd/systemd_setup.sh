#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

SYSTEMD_DIR=/lib/systemd/system/

if [ ! -f /usr/bin/docker-compose ]; then
  ln -s $(which docker-compose) /usr/bin/docker-compose
fi

if cp ./docker-compose* $SYSTEMD_DIR; then
  systemctl daemon-reload
  systemctl enable docker-compose-reload@pihole.timer
  systemctl start docker-compose@pihole docker-compose-reload@pihole.timer
else
  echo "Failure, systemd's units not copied in $SYSTEMD_DIR."
fi
