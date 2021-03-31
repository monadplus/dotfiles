# Package Managers on Arch Linux

Pacman has an official repository.

AUR is a community-driven repository for Arch users.
Package contains a description (PKGBUILD) that allow you to compile a package from source with `makepkg` and then install it via `pacman`

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

### Paru

Arch Linux AUR helper tool (not official tool).
It helps you to install package from PKGBUILD.

Does not require sudo privileges.

```bash
# Interactively search and install <target>.
paru <target>

# Alias for paru -Syu.
paru

# Install a specific package.
paru -S <target>

# Upgrade AUR packages.
paru -Sua --

# Print available AUR updates.
paru -Qua

# -- Download the PKGBUILD and related files of <target>.
paru -G <target>

# Print the PKGBUILD of <target>.
paru -Gp <target>

# Build and install a PKGBUILD in the current directory.
paru -Ui
```
