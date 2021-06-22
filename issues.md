# Issues & Solutions

## Downgrading a package

See https://wiki.archlinux.org/index.php/Downgrading_packages#Automation

There's the tool `downgrade` that searches on your local pacman cache `/var/cache/pacman/pkg/` and on the [Arch Linux Archive](https://wiki.archlinux.org/index.php/Arch_Linux_Archive).

To use this tool:

```bash
downgrade <lib name>
```

To upgrade multiple packages at once (e.g. dependencies):

```bash
downgrade gcc gcc-libs
```

## Left click on the touchpad is not working properly

```bash
# Check what's happening
sudo libinput debug-events

# Usually reloading the mouse from the kernel solves the problem
sudo modprobe -r psmouse
sudo modprobe psmouse proto=imps
```

## Failed to start Load/Save Screen Backlight Brightness (**neither of these works**):

This is a known issue (https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_T495s)

```bash
# check
systemctl status systemd-backlight@backlight:acpi_video0.service
```

The solution is to mask (ignore) the error:

```bash
systemctl status systemd-backlight@backlight:acpi_video0.service
```

I tried to fix the error (instead of masking it) but it has no (visible) effect:

```bash
#/etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="quiet acpi_backlight=vendor" # acpi_osi=Linux

# Then
sudo grub-mkconfig
```

## GHC and xmonad

When installing xmonad with pacman, it will also install the newest ghc.

If you install a new ghc (i.e. nix-env -iA ghcXXX), calling `xmonad --recompile` will fail because xmonad falls to the new installed ghc without the xmonad libraries. For this reason the `~/.nixpkgs/config.nix` has xmonad libraries installed.

**Do NOT remove the installed GHC from pacman** since the one installed from nix cannot be found by the root and the computer will not boot. It would be possible to remove it and sourcing nix from root but not sure how to do it.

> The default xmonad captures Ctrl+w for screen swapping.

## Bluetooth: can't connect/remove device

This happens after waking your pc from hibernate.

The [issue](https://github.com/linrunner/TLP/issues/180) is solved here.

You can check it this way:

```bash
# check the bluetooth status
rfkill list

# If the status is blocked on
# rfkill unblock bluetooth
```

This is adding `RESTORE_DEVICE_STATE_ON_STARTUP=1` in `etc/tlp.conff`.

## Pacman: can't update because of corrupted pgp

Error message:

```bash
error: arcolinux_repo: key "79B328FBCB2C2E8C3B1983244B1B49F7186D8731" is unknown
:: Import PGP key 79B328FBCB2C2E8C3B1983244B1B49F7186D8731? [Y/n] y
error: key "79B328FBCB2C2E8C3B1983244B1B49F7186D8731" could not be looked up remotely
error: failed to update arcolinux_repo (invalid or corrupted database (PGP signature))
error: failed to synchronize all databases
```

Solution found at: https://arcolinuxforum.com/viewtopic.php?f=79&t=2214

The files to watch are:

- /etc/pacman.conf
- /etc/pacman.d/mirrorXXX
- /etc/pacman.d/gnupg/gpg.conf

## Alacritty: libGL error.

Error message

```
alacrity libGL error: MESA-LOADER: failed to open radeonsi (search paths /usr/lib/dri)
```

In order to solve this I reinstalled libGL and mesa `sudo pacman -Syu libGL mesa`

## stack build error

```bash
/usr/bin/ld.lld: error while loading shared libraries: libLLVM-10.so: cannot open shared object file: No such file or directory
collect2: error: ld returned 127 exit status
`gcc' failed in phase `Linker'. (Exit code: 1)
```

The problem: I forgot to update `lld` after upgrading `llvm` from version 10 to 11.

The fix: upgrade `lld` by `sudo pacman -Syu ldd`.

## ipython autocomplete doesn't works

Solved by

```bash
pip install -U ipython
pip install -U jedi
```

## After system update, I was redicted to sddm with an error message about a theme. In reality, the problem was related to xmonad not properly starting due to a missing xmonad-contrib.so. 

Solved by `xmonad --recompile` (open a terminal by Ctr+Alt+F3)
