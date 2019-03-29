FROM pihole/pihole:latest

COPY 99-custom_domains.conf /etc/dnsmasq.d/
