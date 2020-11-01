# Dotfiles

The following dotfiles were tested on Arch Linux.

For a basic good on how to install Arc Linux: [here](./arch-linux.md).

## Configuration

The list of configurations directories/files that must be placed in ~/.config are:

- alacritty.yml
- autostart
- htop
- neofetch
- nvim
- polybar
- redshift
- nixpkgs (the directory)
- ...

### Touchpad (Synaptic)

Touchpad is managed through [Touchpad Synaptics](https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Configuration)

You need to install the drivers xf86-input-synpatics and add your configuration at /etc/X11/xorg.conf.d/70-synaptics.conf

```bash
sudo ln -s ~/dotfiles/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf
sudo ln -s ~/dotfiles/70-synaptics.conf /etc/X11/xorg.conf.d/70-synaptics.conf
sudo ln -s ~/dotfiles/99-killX.conf /etc/X11/xorg.conf.d/99-killX.conf
```

### TLP

Install:

``` bash
sudo pacman -Syy tlp
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

There are two options (I recommend alacritty):

- Alacritty

```bash
# Everything configured
ln -s ~/dotfiles/alacritty.yml ~/.config/alacritty.yml
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

### Font

Fonts are installed at

- system-wide `/usr/share/fonts/`
- single user `~/.local/share/fonts/`

Use `fc-list` to display all available fonts.

Fonts can be installed from [pacman/AUR](https://wiki.archlinux.org/index.php/Fonts#Font_packages). Example:

- `yay -S ttf-iosevka`

A list of available fonts

### Text Editor

I am currently using doom-emacs as my editor

- vim (nvim): follow [instructions](./nvim/README.md)
- emacs (doom-emacs): follow [instructions](./emacs/README.md)

The directory `org` contains org files. And should be `ln -s ~/dotfiles/org ~/org`

### ZSH and oh-my-zsh

```bash
sudo pacman -S zsh zsh-completions
chsh -s $(which zsh) # change user shell
echo $SHELL # check shell is zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # Install oh-my-zsh
# Install a powerline font: https://github.com/powerline/fonts
ln -s ~/dotfiles/.zshrc ~/.zshrc # link
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
# ~/.zshrc
ZSH_THEME="powerlevel10k/powerlevel10k"
# Oppen the shell and follow the powerlevel10k wizard
```

### [GPG](https://wiki.archlinux.org/index.php/GnuPG)

```bash
# Install
sudo pacman -Syy gnupg

# Encrypt
gpg -c filename  # Insert your password in the prompt

# Decrypt
gpg filename.gpg  # Insert your password in the prompt
```

#### gpg-agent

gpg-agent is mostly used as daemon to request and cache the password for the keychain. 

Configuration file: `~/.gnupg/gpg-agent.conf`

To reload configuration:

``` bash
$ gpg-connect-agent reloadagent /bye
OK
```

### Zathura

```bash
sudo pacman -Syy zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb
```

### Printers

- [Cups](https://wiki.archlinux.org/index.php/CUPS)
- [Avahi](https://wiki.archlinux.org/index.php/Avahi) (local hostname resolution)

```bash
sudo pacman -Syy cups cups-pdf avahi system-config-printer
sudo systemctl enable org.cups.cupsd.service
sudo systemctl start org.cups.cupsd.service
sudo systemctl enable avahi-daemon.service
sudo systemctl start avahi-daemon.service
```

Show network printers: `avahi-discover` or `avahi-browse --all --ignore-local --resolve --terminate`

`system-config-printer` is a gui manager.
It automatically discovered the printer and installed the drivers.
Set the printer as default,
Allows to see ink levels

List devices: `lpinfo -v`

To print a pdf: `lpr file` (you may need to specify the printer)

`lpr --help` for more information.

Don't install `ink` (not working)

### Clipboard Manager

clipmenu and clipmenud

### Redshift

```bash
ln -s ~/dotfiles/redshift ~/.config/redshift
```

### Java

See [wiki](https://wiki.archlinux.org/index.php/Java)

```bash
sudo pacman -Syy jre-openjdk
#sudo pacman -Syy jdk-openjdk # For development

# Common packages
sudo pacman -Syy java-runtime-common
sudo pacman -Syy java-environment-common
```

### Docker

```bash
sudo pacman -Syy docker
sudo usermod -aG docker $USER # add user to docker group
systemctl enable docker.service
systemctl start docker.service
# (optional) logout and login to reload your permissions
kill -9 -1
docker info # should work
```

### BitTorrent Clients

Install `Deluge` bittorrent client:

```bash
sudo pacman -Syy  deluge deluge-gtk
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
- lazydocker: terminal ui for docker (be careful, the PKGBUILD uninstall go :rofl:)
- autorandr

```bash
sudo pacman -Syy macho fd obs-studio ncdu aws-cli docker-compose pandoc
yay -S pgcli lazydocker
nix-env -iA nixpkgs.haskellPackages.pandoc
nix-env -iA nixpkgs.haskellPackages.hlint
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
```

### Latex

```bash
# This takes a looooooooong time
sudo pacman -Syy texlive-most texlive-lang biber
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
sudo pacman -Syy vlc playerctl

# playerctl provices command line tool to send commands to MPRIS clients (VLC)
playerctl play-pause --player=vlc
```

VLC can stream to chromecast!

### LLVM

This install llvm compiler and (optional) toolchain.

```bash
install llvm clang lld lldb libc++
```

Seems to be installed at `/usr/include/llvm`

### NPM

To see the list of intalled packages: `npm list` or `npm -g list`

Check npm directory: `npm root` or `npm -g root`

To install a package `npm install package-name` (-g)

#### issue after installing npm

After installing npm (`sudo pacman -Syy npm`), the `node_modules` was created at `~/dotfiles` (WTF!).

I had to manually move the `node_modules` directory to `$HOME` and change the default configuration:

``` bash
$ npm config list
# add cwd
$ vim ~/.npmrc # You can also use $ npm config set cwd ""
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

If you install a new ghc (i.e. nix-env -iA ghcXXX), calling `xmonad --recompile` will fail.

You need to remove the installed ghc

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
