# Arch Linux

These is a step-by-step installation guide for **my** arch linux main system.

**All steps after installing the display/window manager are missing**

!!! I am currently using Arcolinux were all these steps are automated.

## Installation

Follow the steps (for more information: https://wiki.archlinux.org/index.php/Installation_guide ):

```bash
ping google.com # should work, check you have wired internet connection
timedatectl set-ntp true # Not sure why you need this

# Display all disk: fdisk -l
fdisk /dev/nvme0n1
fdisk> g # GPT for UEFI
fdisk> n # 1, default, +550M # EFI partition
fdisk> n # 2, default, +2G # swap
fdisk> n # 3, default, default # root
fdisk> t # 1, 1(efi system)
fdisk> t # 2, 19(linux swap)
fdisk> w

mkfs.fat -F32 /dev/nvme0n1p1
mkswap /dev/nvme0n1p2
swapon /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3
mount /dev/nvme0n1p3 /mnt

pacstrap /mnt base linux linux-firmware # Installs linux

genfstab -U /mnt >> /mnt/etc/fstab # generates fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime # timezone
hwclock --systohc

pacman -S vim
vim /etc/locale.gen # Uncomment en_US.UTF-8 UTF-8
locale-gen

vim /etc/host # hades
> hades
vim /etc/hosts
> 127.0.0.1   localhost
> ::1         localhost
> 127.0.1.1   hades.localdomain   hades

passwd # for the root user
useradd -m arnau
passwd arnau # for arnau user
usermod -aG wheel,audio,video,optical,storage arnau
pacman -S sudo
EDITOR=vim visudo # uncomment %wheel ALL=(ALL) ALL
pacman -S grub efibootmgr dosfstools os-prober mtools
mkdir /boot/EFI
mount /dev/nvme0n1p1 /boot/EFI
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S networkmanager git firefox base-devel # base-devel: make, autoconf ...
systemctl enable NetworkManager

exit
umount -l /mnt
reboot
```

Disconnect the usb and reboot! You should have a running bare Arch Linux system.

## yay

```bash
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si # install
```

## Fonts

https://wiki.archlinux.org/index.php/Fonts

```bash
sudo pacman -Syy fontconfig ttf-inconsolata ttf-iosevka
yay -Syu ttf-mononoki

# List fonts
fc-list | less
```

## NetworkManager

```bash
# Already installed in #Installation
# pacman -S networkmanager
# systemctl enable NetworkManager
sudo pacman -Syu network-manager-applet
# autostart.sh will run nm-applet &
```

## Display Manager and Window Manager

```bash
# You may need to install your video drivers: https://wiki.archlinux.org/index.php/Xorg#Driver_installation
sudo pacman -Syy xorg lightdm lightdm-gtk-greeter xmonad xmonad-contrib xmobar dmenu picom nitrogen alacritty # xmonad-extras  is missing (xmonad-extras-git is in AUR)
                   # picom is a compositor for xorg.
sudo systemctl enable ligthdm

You will need to check /etc/lightdm and copy it


# git clone https://github.com/monadplus/dotfiles ~/
You need to do lot of softlinks and check everything is installed

# Setup wallpaper
nitrogen # and pick a wallpaper

# Configure picom
mkdir -p ~/.config/picom/
cp /etc/xdg/picom.conf.example ~/.config/picom/picom.conf
```
