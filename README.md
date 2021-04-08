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

## Configuration

### Touchpad (Synaptic)

Touchpad is managed through [Touchpad Synaptics](https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Configuration)

You need to install the drivers xf86-input-synpatics and add your configuration at /etc/X11/xorg.conf.d/70-synaptics.conf

```bash
sudo ln -s ~/dotfiles/00-keyboard.conf /etc/X11/xorg.conf.d
sudo ln -s ~/dotfiles/70-synaptics.conf /etc/X11/xorg.conf.d
sudo ln -s ~/dotfiles/99-killX.conf /etc/X11/xorg.conf.d
```

I tried to fix mouse speed on powerstation with 50-mouse.conf but it doesn't work.

### Razer (mouse)

Follow instructions from https://wiki.archlinux.org/index.php/Razer_peripherals

`razercfg` didn't work (mouse not detected)

`openrazer` + `polychromatic` works perfect!

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

### Display Manager

I have used in the past `lightdm` and I am currenty using `sddm`.

```bash
sudo rm /etc/sddm.conf
sudo ln -s ~/dotfiles/sddm/sddm.conf /etc/
sudo ln -s ~/dotfiles/sddm/archlinux-simplyblack /usr/share/sddm/themes
sudo ln -s ~/dotfiles/sddm/faces/arnau.face.icon /usr/share/sddm/faces
```

### Window Manager

- `xmonad`:

```bash
mv ~/.xmonad ~/.xmonad-old
ln -s ~/dotfiles/.xmonad ~

# Check if xmonad compiles, otherwise you would have to edit ~/.xmonad/xmonad.hs
xmonad --recompile

# Check ~/.xmonad/scripts/autostart.sh

# This script must not exit otherwise xmonad will fail to run.
# This script is responsible for running all userspace programs and polybar
```

### Status Bar

- `polybar`:

```bash
mv ~/.config/polybar ~/.config/polybar-old
ln -s ~/dotfiles/polybar ~/.config/

# Check ~/.config/polybar/launch.sh
# Run it and check if it works.
# Otherwise, fix it by editing ~/.config/polybar/config
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

### [Backlight](https://wiki.archlinux.org/index.php/Backlight)

**monitor**

``` bash
# Add kernel module
sudo modprobe i2c_dev
sudo pacman -Syu ddcutil
sudo ddcutil capabilities | grep "Feature: 10"
sudo ddcutil getvcp 10
sudo ddcutil setvcp 10 70
```

### Fan Control & Led Control

> Neither fancontrol.service nor liquidcfg.service work.
> The fancontrol problem is stated [here](https://wiki.archlinux.org/index.php/Fan_speed_control#Device_Paths_have_Changed_in_/etc/fancontrol).
> There is a workaround at `.xmonad/scripts/autostart.sh` (a very ugly one).

**Fan Control**

```bash
# Install lm_sensors
sudo pacman -Syu lm_sensors

# Check sensors
sensors

# run configuration (will write on /etc/fancontrol)
sudo pwmconfig
# alternatively
sudo ln -s ~/dotfiles/fancontrol /etc/fancontrol

# test fancontrol is working
sudo fancontrol

# Enable systemd service
sudo systemctl enable fancontrol.service
sudo systemctl start fancontrol.service
```

**Led Control**


[liquidctl](https://github.com/liquidctl/liquidctl) (can also interact with fan control but it does not interact with the temp_cpu).

```bash
sudo pacman -Syu liquidctl
sudo ln -s ~/dotfiles/liquidcfg.service /etc/systemd/system/liquidcfg.service
sudo systemctl enable liquidcfg.service
sudo systemctl start liquidcfg.service
```

Documentation at: https://github.com/liquidctl/liquidctl/blob/master/docs/corsair-commander-guide.md

## Programming Languages
### Nix

```bash
# Install nix for some dependency management
sudo curl -L https://nixos.org/nix/install | sh

# Global config
ln -s ~/dotfiles/nixpkgs/ ~/.config/
```

### Haskell

There is an environment prepared to install ghc, cabal, stack and ghcide.

```bash
nix-env -f '<nixpkgs>' -iA myHaskellEnv
nix-env -f '<nixpkgs>' -iA myGhcid
nix-env -f '<nixpkgs>' -iA myHLS

nix-env -iA nixpkgs.haskellPackages.hlint
# hoogle is already installed by myHaskellEnv
# hoogle is already generated
```

```bash
cabal configure
mv ~/.cabal/config ~/.cabal/config-old
mkdir ~/.stack
ln -s ~/dotfiles/cabal/config ~/.cabal
ln -s ~/dotfiles/.stack/config.yaml ~/.stack/
ln -s ~/dotfiles/.ghci ~/.ghci
```

### Agda

Libraries are installed like `ial` (see `.agda/`).
Recall to `ln -s ~/dotfiles/.agda  ~/.agda`.

I am currently using the one from nix since I also use the ghc from nix.
With the one from pacman, it fails to compile on emacs due to an IEE error.

```bash
# Pacman
sudo pacman -Syu agda agda-stdlib

# Nix
nix-env -f '<nixpkgs>' -iA myAgda # IAL is broken
# Uninstall
nix-env -f '<nixpkgs>' -e '.*agda.*'
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
sudo archlinux-java set java-8-openjdk
```

### Scala

```bash
sudo pacman -Syu scala scala-docs scala-sources sbt maven ammonite
paru -Syu bloop bloop-systemd
systemctl --user enable bloop
systemctl --user start bloop
systemctl --user status bloop

# At 04/2021 the bloop server from AUR is outdated
systemctl --user stop bloop
systemctl --user disable bloop
```


[coc-metals](https://github.com/scalameta/coc-metals) will be automatically installed by vim-plug.

### R

Install:

```bash
sudo pacman -Syu r gcc-fortran tk # gcc-fortran and tk to install packages.
paru rstudio-desktop-bin
```

Alternative, use `nix` (see `nixpkgs/config.nix`)

### Latex

```bash
# This takes a long time
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

### Node

```bash
ln -s ~/dotfiles/.npmrc ~
```

To see the list of installed packages: `npm list` or `npm -g list`

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

```bash
sudo pacman -Syu python jedi-language-server python-pandas python-matplotlib python-scikit-learn python-requests python-statsmodels python-scipy python-pycuda python-pylint python-black python-pyflakes python-isort
sudo pacman -Syu python-tensorflow python-tensorboard_plugin_wit
sudo pacman -Syu python-language-server
```

It is not recommended to installing packages using `sudo pip install`.
Check which packages where not installed using `pacman`.

``` bash
pacman -Qo /usr/lib/pythonXXX/site-packages/* >/dev/null
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

### Rust

```bash
# Install rustup toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rustfmt-preview

# The handicap of this is that +nightly is not added to the env.
rustup +nightly component add rust-analyzer-preview

# I recommend to install it manually
mkdir -p ~/.local/bin/
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer

# Alternative you could install it via pacman
sudo pacman -Syu rust rust-analyzer
```

### C

Neovim requires installing [ccls](https://github.com/MaskRay/ccls/wiki):`sudo pacman -Syu ccls`.

## Essential Software

### Git

```bash
ln -s ~/dotfiles/.gitconfig ~
```

### SSH

All information here https://wiki.archlinux.org/index.php/SSH_keys

I recommend using `keychain` (sudo pacman -S keychain) which reuses ssh-agents for all connections. `keychain` is configured in `.bashrc`/`.zshrc`.

```bash
ln ~/dotfiles/.ssh/config ~/.ssh
```

### OpenSSH

SSH server.

- private_ip = `ifconfig`
- public_ip = https://www.whatsmyip.org/

```bash
sudo pacman -Syu ssh openssh
systemctl enable sshd.service
systemctl start sshd.service
systemctl status sshd.service
# check if working
ssh localhost

# copy configuration
sudo ln -s ~/dotfiles/sshd_config /etc/ssh/
```

Now, access to your router and add port forwarding (TPC, port=22, ip=private_ip).

Now, you should be able to ssh from outside your network by `ssh arnau@public ip` (the public ip can be retrieved from any website).

Adding ssh keys. On the **client**:

```bash
cd ~/.ssh
ssh-keygen -t rsa -b 4096
ssh-copy-id -i id_rsa.pub arnau@private_ip

# now ssh connection should use public/private key
ssh arnau@private_ip
```

You can forward X11 (not done yet): https://wiki.archlinux.org/index.php/OpenSSH#X11_forwarding

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
# powerstation
ln -s ~/dotfiles/alacritty ~/.config
# laptop
mkdir ~/.config/alacritty
ln -s ~/dotfiles/alacritty/alacritty-laptop.yml ~/.config/alacritty/alacritty.yml
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

## Miscellaneous Software

```bash
# Official
sudo pacman -Syu exa ripgrep fd obs-studio ncdu aws-cli docker-compose pandoc youtube-dl autorandr maim brightnessctl gtop nomacs kcolorchooser tldr tokei procs bat

# AUR
paru -Syu pgcli lazydocker direnv
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
systemctl restart sddm
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

### Conky

```bash
ln -s ~/dotfiles/.conkyrc ~
```

### Htop

```bash
rm ~/.config/htop/htoprc
ln -s ~/dotfiles/htop/htoprc ~/.config/htop
```

### Cachix

```bash
nix-env -iA cachix -f https://cachix.org/api/v1/install
cachix use monadplus
cachix authtoken # visit website to generate the token
```

### Psql

```bash
ln -s ~/dotfiles/.psqlrc ~
```
### Gif Recorder

``` bash
paru peek
```

### Twitch

You can use firefox like a regular folk.

Or you can go all command-line hacker:

``` bash
# I use mpv since vlc is buggy (stream doesn't display)
sudo pacman -Syu vlc mpv
sudo pacman -Syu streamlink

# streamlink -p player twitch.tv/name_of_channel quality
streamlink -p mpv twitch.tv/shadesofreality best

# GUI from streamlink (twitch only)
# It has a nice tray icon
paru -Syu streamlink-twitch-gui
```

## Gaming

Install `wine` and `lutris`.

Please check everything from [wine](https://wiki.archlinux.org/index.php/Wine) since it requires a lot of extra dependencies

### World of warcraft

You need to install extra things apart from wine/lutris.

I followed this tutorial: https://www.addictivetips.com/ubuntu-linux-tips/play-world-of-warcraft-on-linux/

Read everything from https://lutris.net/games/world-of-warcraft/
