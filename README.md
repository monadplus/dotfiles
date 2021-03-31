# Dotfiles

The following dotfiles were tested on Arch Linux.

How to install Arc Linux: [here](./arch-linux.md).

## Package Managers on Arch Linux

Pacman has an official repository.

AUR is a community-driven repository for Arch users.
Package contains a description (PKGBUILD) that allow you to compile
a package from source with `makepkg` and then install it via `pacman`

### Pacman

Pacman configuration can be found at: `/etc/pacman.conf`

Keeps the system up to date by synchronizing package lists with the master server.

Pacman includes several tools: `makepkg`, `pactree` (dependency viewer) and `checkupdates`

`checkupdates` is very useful.

Some packages may have optional dependencies which are listed on installation.

__Do not run `pacman -Sy package_name` instead of `pacman -Syu package_name`, as this could lead to dependency issues__

Don't skip packages (i.e. IgnorePkg=linux)
Don't skip package group (i.e. IgnoreGroup=gnome)

Pacman will not remove configurations that the application itself creates (dotfiles).

```bash
# Install specific package
pacman -S package_name1 package_name2
# Install package groups
pacman -S gnome # prompt you to select the packages you wish to install

# Remove package
pacman -Rs package_name # removes unused dependencies

# List installed packages and version
pacman -Q
# List AUR packages
pacman -Qm

# Search already installed packages
pacman -Qs string1 string2
# Search in database
pacman -Ss string1 string2
pacman -Ss '^vim-'
# Search in remote
pacman -F string1 string2

# Install a 'local' package (e.g. AUR)
pacman -U /path/to/package/package-name-version.pkg.tar.zst

# Backup your installed packages list:
pacman -Qqe > pkglist.txt
# Restore installed packages
pacman -S --needed - < pkglist.txt
```

Cleaning the package cache. Pacman stores its downloaded packages in `/var/cache/pacman/pkg/` and does not remove the old or uninstalled versions automatically. This has some advantages. Run

- `paccache -r`: deletes all cached versions of installed and uninstalled packages, except for the most recent 3
- `pacman -Sc`: to remove all cached packages not currently installed.

#### Upgrading the System

Do fully system upgrades.

Have a Linux "live" usb in case you need to rescue your system.

Avoid certain pacman commands: `pacman -Sy`, `--overwrite`, `-d`

Partial upgrades are unsupported. Arch Linux is a rolling release. Always update (`pacman -Syu`) before installing a package. Be carefull with `IgnorePkg` and `IgnoreGroup`. Do not fix the problem simply by symlinking. Use `pacman -Syu`

Reboot after an upgrade.

Orphan packages `pacman -Qtd`.

Always check for PKGBUILD in AUR packages.

Clean package cache `/var/cache/pacman/pkg/` ( I have like 3.5GB of pkgs there...)

### Yay

> DEPRECATED (use paru instead)

Arch Linux AUR helper tool. It helps you to install package from PKGBUILD.

Does not require sudo privileges.

```bash
# Install a package
yay -S package
# Remove a package (and its dependencies)
yay -Rns package
# Search package
yay rstu # returns all entries that start with rstu
# Upgrade all package
yay -Syu
# Clean unnedded dependencies
yay -Yc
# System statistics
yay -Ps
```

### Paru

TODO (similar to yay)

## Configuration

### systemd

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

### Touchpad (Synaptic)

Touchpad is managed through [Touchpad Synaptics](https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Configuration)

You need to install the drivers xf86-input-synpatics and add your configuration at /etc/X11/xorg.conf.d/70-synaptics.conf

```bash
sudo ln -s ~/dotfiles/00-keyboard.conf /etc/X11/xorg.conf.d
sudo ln -s ~/dotfiles/70-synaptics.conf /etc/X11/xorg.conf.d
sudo ln -s ~/dotfiles/99-killX.conf /etc/X11/xorg.conf.d
```

### [Multihead](https://wiki.archlinux.org/index.php/Multihead)

#### RandR

Is an extension of X Window System. Example:

``` bash
xrandr --output VGA1 --auto --output HDMI1 --auto --right-of VGA1
```

You can create virtual display combining multiple screens.

You can configured it through `xorg.conf`:

``` bash
# /etc/X11/xorg.conf.d/10-monitor.conf
Section "Monitor"
    Identifier  "VGA1"
    Option      "Primary" "true"
EndSection

Section "Monitor"
    Identifier  "HDMI1"
    Option      "LeftOf" "VGA1"
EndSection
```

To get the ids: `$ xrandr -q`

#### Arandr

`arandr` is a GUI for `xrandr`.

#### [Autorandr](https://github.com/phillipberndt/autorandr)

Allows you to easily configure xrandr "profiles" that will activate automatically when you connect/disconnect displays.

Install: `sudo pacman -Syu autorandr`

``` bash
# 1.
autorandr --save mobile
# 2. Plug your external monitor
autorandr --save docked
# 3. Reload your setup
autorandr --change
# 4. Manual
autorandr <profile>
```


### TLP

Install:

``` bash
sudo pacman -Syu tlp
sudo systemctl enable tlp.service
sudo systemctl start tlp.service
```

Add configuration file:

``` bash
sudo rm /etc/tlp.conf
sudo ln -s ~/dotfiles/tlp.conf /etc/tlp.conf
```

Configuration options: https://linrunner.de/tlp/settings/

### Terminal Emulator

- Alacritty

```bash
# Everything configured
ln -s ~/dotfiles/alacritty ~/.config
```

- Konsole

```bash
ln -s ~/dotfiles/konsole ~/.local/share/konsole
ln -s ~/dotfiles/konsolerc ~/.config/konsolerc
# I couldn't find where the keybindings file is..
# Add them by hand (copy/paste,clear, etc)
```

### SSH

All information here https://wiki.archlinux.org/index.php/SSH_keys

I recommend using `keychain` (sudo pacman -S keychain) which reuses ssh-agents for all connections. `keychain` is configured in `.bashrc`/`.zshrc`

### AWS

```bash
ln -s ~/dotfiles/.aws ~
# The first time may block since it is creating gpg
cd ~/.aws && gpg credentials.gpg
```

### Font

Fonts are installed at

- system-wide `/usr/share/fonts/`
- single user `~/.local/share/fonts/`

Place `*.otf` at `/usr/share/fonts/opentype`

Use `fc-list` to display all available fonts.

Update the cache: `fc-cache -f -v`

Fonts can be installed from [pacman/AUR](https://wiki.archlinux.org/index.php/Fonts#Font_packages). Example:

- `paru -Syu ttf-iosevka`

A list of available fonts

### Text Editor

I am currently using doom-emacs as my editor

- vim (nvim): follow [instructions](./nvim/README.md)
- emacs (doom-emacs): follow [instructions](./emacs/README.md)

### ZSH and oh-my-zsh

```bash
sudo pacman -S zsh zsh-completions
chsh -s $(which zsh) # change user shell
echo $SHELL # check shell is zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # Install oh-my-zsh
# Install a powerline font: https://github.com/powerline/fonts
ln -s ~/dotfiles/.zshrc ~/.zshrc # link
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/themes/powerlevel10k
# Oppen the shell and follow the powerlevel10k wizard
```

### [GPG](https://wiki.archlinux.org/index.php/GnuPG)

```bash
# Install
sudo pacman -Syu gnupg

# Encrypt
gpg -c filename  # Insert your password in the prompt

# Decrypt
gpg filename.gpg  # Insert your password in the prompt
```

#### gpg-agent

gpg-agent is mostly used as daemon to request and cache the password for the keychain.

```bash
mkdir ~/.gnupg
ln -s ~/dotfiles/gpg-agent.conf ~/.gnupg

# reload and ceck
$ gpg-connect-agent reloadagent /bye
OK
```

### Zathura

```bash
sudo pacman -Syu zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb
```

### Printers

- [Cups](https://wiki.archlinux.org/index.php/CUPS)
- [Avahi](https://wiki.archlinux.org/index.php/Avahi) (local hostname resolution)

```bash
sudo pacman -Syu cups cups-pdf avahi system-config-printer
sudo systemctl enable cups.service
sudo systemctl start cups.service
sudo systemctl enable avahi-daemon.service
sudo systemctl start avahi-daemon.service
```

Run `system-config-printer` (gui config tool). It automatically discovered the printer and installed the drivers. Set the printer as default, Allows to see ink levels

List devices: `lpinfo -v`

To print a pdf: `lpr file` (you may need to specify the printer)

`lpr --help` for more information.

Don't install `ink` (not working)

### Clipboard Manager

clipmenu and clipmenud

### Redshift

```bash
ln -s ~/dotfiles/redshift ~/.config
```

### Java

See [wiki](https://wiki.archlinux.org/index.php/Java)

```bash
sudo pacman -Syu jdk8-openjdk
sudo pacman -Syu jdk11-openjdk
```

Use `archlinux-java` to switch between version:

```
archlinux-java status
sudo archlinux-java set jdk-8-openjdk
```

### Scala

```bash
sudo pacman- Syu scala scala-docs scala-sources sbt maven ammonite
```

[coc-metals](https://github.com/scalameta/coc-metals) will be automatically installed by vim-plug.

### Docker

```bash
sudo pacman -Syu docker
sudo usermod -aG docker $USER # add user to docker group
systemctl enable docker.service
systemctl start docker.service
# (optional) logout and login to reload your permissions
kill -9 -1
docker info # should work
```

I recommend using `lazydocker`.

### R and RStudio IDE

FIXME: I had to install an older version of `R` due to the `icu` issue.

Install:

```bash
pacman -Syu r
paru -Syu rstudio-desktop-bin
pacman -Syu tk # required by rstudio
```

Alternative, use `nix` (see `nixpkgs/config.nix`)

### BitTorrent Clients

Install `Deluge` bittorrent client:

```bash
sudo pacman -Syu  deluge deluge-gtk
systemctl enable deluged.service
systemctl start deluged.service
```

### Utils

- macho: better man
- fd: better find
- ncdu: disk space analyzer (really good)
- zeal: programming language offline docs
- rtv: reddit from terminal
- youtube-dl: youtube download video/audio
- pgcli: better psql
- lazydocker: terminal ui for docker
- autorandr
- maim
- brightnessctl
- gtop
- nomacs

```bash
sudo pacman -Syu macho fd obs-studio ncdu aws-cli docker-compose pandoc
paru -S pgcli lazydocker
nix-env -iA nixpkgs.haskellPackages.hlint
```

### htop

```bash
rm ~/.config/htop/htoprc
ln -s ~/dotfiles/htop/htoprc ~/.config/htop
```


### Cachix

```bash
$ nix-env -iA cachix -f https://cachix.org/api/v1/install
$ cachix use ghcide-nix
```

### Haskell

There is an environment prepared to install ghc, cabal, stack and ghcide.

```bash
nix-env -f '<nixpkgs>' -iA myHaskellEnv
nix-env -f '<nixpkgs>' -iA myGhcid
nix-env -f '<nixpkgs>' -iA myHLS

nix-env -iA nixpkgs.haskellPackages.hoogle
hoogle generate # this takes some minutes
```

```bash
cabal configure
ln -s ~/dotfiles/cabal/config ~/.cabal
ln -s ~/dotfiles/.stack/config.yaml ~/.stack/
ln -s ~/dotfiles/.ghci ~/.ghci
```

### Agda

Libraries are installed like `ial` (see `.agda/`).

Recall to `ln -s ~/dotfiles/.agda  ~/.agda`

```bash
nix-env -f '<nixpkgs>' -iA myAgda
```

### psql

`ln -s ~/dotfiles/.psqlrc ~`

### Latex

```bash
# This takes a looooooooong time
sudo pacman -Syu texlive-most texlive-lang biber
```

To determine which CTAN packages are included in each texlive- package, look up the files `/var/lib/texmf/arch/installedpkgs/<package>_<revnr>.pkgs.`

This should be enough, otherwise have a look at the [Wiki](https://wiki.archlinux.org/index.php/TeX_Live)

### Power Management

See [wiki](https://wiki.archlinux.org/index.php/Power_management#Power_management_with_systemd)

Power management through systemd:

```bash
systemctl suspend
```

Hibernate requires [some tweaking](https://wiki.archlinux.org/index.php/Power_management/Suspend_and_hibernate#Hibernation).
For arcolinux, it seems to work out of the box:

```bash
systemctl hibernate
```

How to change PowerKey to suspend instead of poweroff

```bash
# Pick one:
#   $ sudo vim /etc/systemd/logind.conf
#   $ sudo vim /etc/systemd/logind.conf.d/*.conf
> [Login]
> HandlePowerKey=suspend

# Restart logind
systemctl kill -s HUP systemd-logind
```

### Kernel parameter

Loadable modules are set via `.conf` files in `/etc/modprobe.d/`

For example, to disable beep:

```bash
# sudo vim /etc/modprobe.d/nobeep.conf
> blacklist pcspkr
```
### Media Player

There is a lot of free media players.

I am currently using [vlc](https://wiki.archlinux.org/index.php/VLC_media_player)

```bash
sudo pacman -Syu vlc playerctl

# playerctl provices command line tool to send commands to MPRIS clients (VLC)
playerctl play-pause --player=vlc
```

VLC can stream to chromecast!

### LLVM

This install llvm compiler and (optional) toolchain.

```bash
install llvm clang lld lldb libc++
install llvm-libs # libLLVM.so
```

Seems to be installed at `/usr/include/llvm` and `/usr/lib/libLLVM-11.so`

To update just call `install` again.

### NPM

To see the list of intalled packages: `npm list` or `npm -g list`

Check npm directory: `npm root` or `npm -g root`

To install a package `npm install package-name` (-g)

#### issue after installing npm

After installing npm (`sudo pacman -Syu npm`), the `node_modules` was created at `~/dotfiles` (WTF!).

I had to manually move the `node_modules` directory to `$HOME` and change the default configuration:

``` bash
$ npm config list
# add cwd
$ vim ~/.npmrc # You can also use $ npm config set cwd ""
```

### Python

It is not recommended to installing packages using `sudo pip install`.

Let `pacman` manage the packages for you.

Check which packages where not installed using `pacman`.

``` bash
pacman -Qo /usr/lib/python3.8/site-packages/* >/dev/null
```

To check which packages depend on a package:

``` bash
pip show <package> # See Required section
```

Uninstall packages from `pip`:

``` bash
# User     .local/lib/python...
pip uninstall
# Global   /usr/lib/python3.8/site-packages/...
sudo pip uninstall
```

## Gif Recorder

``` bash
paru -S peek
```

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

### Issues and Solutions

#### Left click on the touchpad is not working properly

```bash
# Check what's happening
sudo libinput debug-events

# Usually reloading the mouse from the kernel solves the problem
sudo modprobe -r psmouse
sudo modprobe psmouse proto=imps
```

#### Failed to start Load/Save Screen Backlight Brightness (**neither of these works**):

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

#### GHC and xmonad

When installing xmonad with pacman, it will also install the newest ghc.

If you install a new ghc (i.e. nix-env -iA ghcXXX), calling `xmonad --recompile` will fail because xmonad falls to the new installed ghc without the xmonad libraries. For this reason the `~/.nixpkgs/config.nix` has xmonad libraries installed.

**Do NOT remove the installed GHC from pacman** since the one installed from nix cannot be found by the root and the computer will not boot. It would be possible to remove it and sourcing nix from root but not sure how to do it.

> The default xmonad captures Ctrl+w for screen swapping.

#### Bluetooth: can't connect/remove device

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

#### Pacman: can't update because of corrupted pgp

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

#### Alacritty: libGL error.

Error message

```
alacrity libGL error: MESA-LOADER: failed to open radeonsi (search paths /usr/lib/dri)
```

In order to solve this I reinstalled libGL and mesa `sudo pacman -Syu libGL mesa`

#### stack build error

```bash
/usr/bin/ld.lld: error while loading shared libraries: libLLVM-10.so: cannot open shared object file: No such file or directory
collect2: error: ld returned 127 exit status
`gcc' failed in phase `Linker'. (Exit code: 1)
```

The problem: I forgot to update `lld` after upgrading `llvm` from version 10 to 11.

The fix: upgrade `lld` by `sudo pacman -Syu ldd`.

#### ipython autocomplete doesn't works

Solved by

```bash
pip install -U ipython
pip install -U jedi
```
