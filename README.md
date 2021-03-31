# Arch Linux: Dotfiles

Index:

- [Configuration](#configuration)
- [Programming Languages](#programming-languages)
- [Software: Essential](#essential-software)
- [Software: Miscelaneous](#miscelaneous-software)

The following dotfiles were tested on Arcolinux.

- Issues & Solutions: [here](./issuesAndSolutions.md)
- How to install Arc Linux: [here](./arch-linux.md).
- Linux directories explained: [here](./linux_directories.md)
- Pacman: [here](./pacman.md)
- Systemd: [here](./systemd.md)
- Ripgrep: [here](./ripgrep.md)


<!--****************************************************-->
<!--****************************************************-->
<!--**************** Configuration *********************-->
<!--****************************************************-->
<!--****************************************************-->

## Configuration

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

### TLP (laptops only)

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

### Power Management

See [wiki](https://wiki.archlinux.org/index.php/Power_management#Power_management_with_systemd)

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

For example, to disable beep (laptop I guess):

```bash
# sudo vim /etc/modprobe.d/nobeep.conf
> blacklist pcspkr
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

<!--****************************************************-->
<!--****************************************************-->
<!--************  Programming Languages ****************-->
<!--****************************************************-->
<!--****************************************************-->

## Programming Languages

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

### R and RStudio IDE

FIXME: I had to install an older version of `R` due to the `icu` issue.

Install:

```bash
pacman -Syu r
paru -Syu rstudio-desktop-bin
pacman -Syu tk # required by rstudio
```

Alternative, use `nix` (see `nixpkgs/config.nix`)

### Latex

```bash
# This takes a looooooooong time
sudo pacman -Syu texlive-most texlive-lang biber
```

To determine which CTAN packages are included in each texlive- package, look up the files `/var/lib/texmf/arch/installedpkgs/<package>_<revnr>.pkgs.`

This should be enough, otherwise have a look at the [Wiki](https://wiki.archlinux.org/index.php/TeX_Live)


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

After installing npm (`sudo pacman -Syu npm`), the `node_modules` was created at `~/dotfiles` (WTF!).

I had to manually move the `node_modules` directory to `$HOME` and change the default configuration:

``` bash
$ npm config list
# add cwd
$ vim ~/.npmrc # You can also use $ npm config set cwd ""
```

### Python

It is not recommended to installing packages using `sudo pip install`.

Let `pacman` manage the packages for you. For example: `sudo pacman -Syu python-pandas`

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

<!--****************************************************-->
<!--****************************************************-->
<!--*************  Software Essential ******************-->
<!--****************************************************-->
<!--****************************************************-->

## Esential Software

### SSH

All information here https://wiki.archlinux.org/index.php/SSH_keys

I recommend using `keychain` (sudo pacman -S keychain) which reuses ssh-agents for all connections. `keychain` is configured in `.bashrc`/`.zshrc`

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

```
sudo pacman -Syu clipmenu
```

It is run on `~/.xmonad/scripts/autostart.sh`

### Redshift

```bash
ln -s ~/dotfiles/redshift ~/.config
```

It is run on `~/.xmonad/scripts/autostart.sh`

### Media Player

There is a lot of free media players.

I am currently using [vlc](https://wiki.archlinux.org/index.php/VLC_media_player)

```bash
sudo pacman -Syu vlc playerctl

# playerctl provices command line tool to send commands to MPRIS clients (VLC)
playerctl play-pause --player=vlc
```

VLC can stream to chromecast!

## Gif Recorder

``` bash
paru -S peek
```

<!--****************************************************-->
<!--****************************************************-->
<!--************  Software Miscelaneous ****************-->
<!--****************************************************-->
<!--****************************************************-->

## Miscelaneous Software

```bash
# Official
sudo pacman -Syu fd obs-studio ncdu aws-cli docker-compose pandoc youtube-dl autorandr maim brightnessctl gtop nomacs

# AUR
paru -Syu pgcli lazydocker zeal

# nix
nix-env -iA nixpkgs.haskellPackages.hlint
```

### AWS

```bash
ln -s ~/dotfiles/.aws ~
# The first time may block since it is creating gpg
cd ~/.aws && gpg credentials.gpg
```

### Zathura

Pdf, djvu reader.

```bash
sudo pacman -Syu zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb
```

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

### BitTorrent Clients

Install `Deluge` bittorrent client:

```bash
sudo pacman -Syu  deluge deluge-gtk
systemctl enable deluged.service
systemctl start deluged.service
```

### Htop

```bash
rm ~/.config/htop/htoprc
ln -s ~/dotfiles/htop/htoprc ~/.config/htop
```

### Cachix

```bash
$ nix-env -iA cachix -f https://cachix.org/api/v1/install
$ cachix use ghcide-nix
```

### Psql

`ln -s ~/dotfiles/.psqlrc ~`
