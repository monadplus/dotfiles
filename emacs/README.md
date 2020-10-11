# Emacs

Useful commands:

```bash
doom help COMMAND
doom sync # synchronize your config with Doom Emacs
doom upgrade (--packages)
doom env
doom doctor # diagnose common issues
doo mpurge # delte old, orphaned packages
```

### Installation

Documentation [here](https://github.com/hlissner/doom-emacs/blob/develop/docs/getting_started.org#configure)

First install `emacs` (current version 27.1), `git`, `ripgrep` and `find` (or `fd`):

```bash
sudo pacman -Syy emacs git find ripgrep fd shellcheck
```

Then, install `Doom Emacs`:

```bash
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
# accept all-the-incon's fonts

# Verify everything went well
doom doctor
```

This will expose `doom` cli:

```bash
# .zshrc
> if [ -d "$HOME/.emacs.d/bin" ] ;
>   then PATH="$HOME/.emacs.d/bin:$PATH"
> fi
>
> export DOOMDIR=$HOME/.doom.d
```

### Configure

Doom expects

You can configure Doom by tweaking the files found in your DOOMDIR. Doom expects this directory to be found in one of:

- `~/.config/doom` (respects $XDG_CONFIG_HOME)
- or `~/.doom.d`

Configuration files:

- `init.el`: `doom!` block that controls what Doom modules are enabled.
- `packages.el`: package management is done from this file (don't do it manually!)
- `config.el`: configuration. Evaluated after all the modules have loaded.

Macros can be found [here](https://github.com/hlissner/doom-emacs/blob/develop/docs/api.org#map)

Change leader:

```elisp
;;; add to ~/.doom.d/config.el
(setq doom-leader-key ","
      doom-localleader-key "\\")
```

### Everything you need to install

markdown: [+grip](https://github.com/seagle0128/grip-mode)

### Issues

1. When Emacs is started under X11 and not directly from a terminal some variables are not set:
   - keychain
   - some PATH directories

2. vterm very slow: the problem was related to `exa ... --icons`. Removing `--icons` worked.

3. Projectile not working: I somehow introduced a bad route which couldn't be parsed. I had to manually edit the file `~/.emacs.d/.local/cache/projectile.projects`
