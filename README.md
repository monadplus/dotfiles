Dotfiles
========

The following instructions are only for Arch Linux.

## TODO

Add these files to dotfiles:

- /etc/X11/xorg.conf.d/70-synaptics.conf
- ~/.xmonad
- ~/.config/polybar/

### .config

The list of configurations directories/files that must be placed in ~/.config are:

- alacritty.yml
- autostart
- htop
- neofetch
- nvim
- polybar
- redshift

### Text Editor

Follow [nvim instructions](./nvim/README.md)

### Terminal Emulator

```bash
ln -s ~/dotfiles/konsole ~/.local/share/konsole
ln -s ~/dotfiles/konsolerc ~/.config/konsolerc
# I couldn't find where the keybindings file is..
# Add them by hand (copy/paste,clear, etc)
```

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

### Touchpad

Touchpad is managed through [Touchpad Synaptics](https://wiki.archlinux.org/index.php/Touchpad_Synaptics#Configuration)

You need to install the drivers xf86-input-synpatics and add your configuration at /etc/X11/xorg.conf.d/70-synaptics.conf

### GPG

```bash
# Install
sudo pacman -Syy gnupg

# Encrypt
gpg -c filename  # Insert your password in the prompt

# Decrypt
gpg filename.gpg  # Insert your password in the prompt
```

### Zathura

```bash
sudo pacman -Syy zathura zathura-djvu zathura-pdf-mupdf zathura-ps zathura-cb
```

### Clipboard Manager

clipmenu and clipmenud

### Redshift

```bash
ln -s ~/dotfiles/redshift ~/.config/redshift
```

### Bugs & Solutions

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
