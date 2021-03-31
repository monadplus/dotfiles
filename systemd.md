# Systemd

It provides a system and service manager that runs as PID 1 and starts the rest of the system
It does a lot of other things.

Usage:

```bash
# list all units
systemctl
# System status
systemctl status
# units that have failed
systemctl --failed
```

Units can be, for example, services (.service), mount points (.mount), devices (.device) or sockets (.socket).

You need to specify the type of the unit.  Some assumptions:
- netctl == netctl.service
- /home == home.mount
- /dev/sda2 == dev-sda2.device

```bash
systemctl status unit

systemctl is-enabled unit
systemctl enable unit # start at boot
systemctl disable unit

systemctl start unit
systemctl stop unit
systemctl restart unit
systemctl reload unit # configuration

systemctl daemon-reload # whole daemon
```

Power management

```bash
systemctl reboot
systemctl poweroff
systemctl suspend
systemctl hibernate
systemctl hybrid-sleep
```

Unit files are stored at `/etc/systemd/` (check it `systemctl show --property=UnitPath`)
