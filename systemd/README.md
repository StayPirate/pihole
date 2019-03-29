### Pi-Hole Container Auto-Update
To automatically update the Pi-Hole's container, I leverage systemd's [`services`](https://www.freedesktop.org/software/systemd/man/systemd.service.html) and [`timers`](https://www.freedesktop.org/software/systemd/man/systemd.timer.html).

In this directory you can find the following four files:
 - [`docker-compose@.service`](docker-compose@.service) is the main unit.
 - [`docker-compose-reload@.service`](docker-compose-reload@.service) and [`docker-compose-reload@.timer`](docker-compose-reload@.timer), are used to schedule the update task.
 - [`systemd_setup.sh`](systemd_setup.sh) to easily deploy the above units and configure systemd to use them.

As the default, the container will be updated every day at 3 am, or at the first occurrence in case the server has not been able to execute the scheduled task (e.g. it was powered off at 3 am). You can change this behavior editing the `[Timer]` stanza in the [`timer`](docker-compose-reload@.timer) unit.

#### How to use it
First of all, make sure you downloaded my repository inside `/opt` directory. Since I hardcoded `/opt/pihole` in `docker-compose@.service`, that would be the default `WorkingDirectory`. If you wish to use another location, change the proper path it in the [`service`](docker-compose@.service) unit.  

You can now proceed by following these steps:
 - Make the bash script executable with `chmod +x systemd_setup.sh`.
 - Run it with root privilesge `sudo ./systemd_setup.sh`.

If no errors are printed out the installation succeeded. You can double check if a scheduled task has been added with `systemctl list-timers --all`.
