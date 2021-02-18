# The Linux Directory Structure

- `/bin`: essential user binaries. Contains emergency repairs, booting and single user mode.
- `/sbin`: essential root binaries
- `/boot`: static boot files (linux kernels and GRUP boot loaders)
- `/dev`: devices as (special) files. For example, `/dev/sda` first SATA drive. Also contains pseudodevices such as `/dev/random`, `/dev/null`
- `/etc`: system configuration files (user's are at user's homes). For example X11 configuration is at `/etc/X11/xorg.conf.d/` and `/usr/share/X11/xorg.conf.d/`.
- `/home`: home folders
- `/lib`: essential shared libraries by `/bin` and `/sbin` binaries.
- `/lost+found`: recovered files
- `/media`: removable media: usb, CD, etc. (arch linux mounts in `/run/media`)
- `/mnt`: temporary mount points. Historically, used to mount temporary file systems. For example, mounting a windows partition to recover it.
- `/opt`: used by proprietary software to store data (e.g. discord, dropbox, enpass, google, zoom ...)
- `/proc`: kernel & process (special) files.
- `/sys`: filesystem-like view of information and configuration settings that the kernel provides, much like `/proc`. For example `echo N > /sys/class/backlight/acpi_video0/brightness`
- `/root`: root home directory
- `/run`: place to store transient files (do not stores files in /tmp since may be deleted.)
- `/tmp`: temporary files, deleted whenever your system is restared. May be deleted at any time by utilities such as tmpwatch.
- `/usr`: user binaries and read-only data.
    - `/usr/bin`: non-essential user binaries
    - `/usr/sbin`: non-essential root binaries
    - `/usr/lib`: shared libraries for `/usr/{bin,sbin}`
    - `/usr/include`: header's files, needed for compiling user space source code.
    - `/usr/share`(plenty of things): any program which contains or requires data that doesn't need to be modified should store that data here. For example, X11, alsa, zsh, vim, wine, tlp, etc store data here.
      - `usr/share/man`
      - `usr/share/fonts`
    - `/usr/etc`: unused
    - `/usr/local`: unused
    - `/usr/src`: kernel sources, header-files and docs.
- `/srv`: data for services. For example, Apache HTTP would store the website here. In my system you find empty directories `/srv/ftp/`, `/srv/http/`.
- `/var`: same as `/usr` but writable:
    - `/var/log`: logs
    - `/var/cache`: e.g. `pacman` saves files here
    - `/var/lib`:


On Arch Linux:
- `/bin` and `/sbin` are symlinked to `/usr/bin`
- `/lib` and `/lib64` are symlinked to `/usr/lib`
- `/usr/src/` is empty.

- `/nix` mounts on `/`.
