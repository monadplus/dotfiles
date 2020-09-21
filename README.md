Dotfiles
========

## Applications

- emacs
- dmenu
- stalonetray
- udiskie - Automounter for removable media
- xscreensaver - Screen saver and locker for X Window System
- mkpasswd
- input-utils - lsinput: keyboard input
- arandr - Graphical xrandr
- pavucontrol - Configure bluetooth device
- ddcutil - Query and change Linux monitor settings using DDC/CI and USB
- brightnessctl - backlight utility
- wpa_supplicant
- wpa_supplicant_gui
- nitrogen - Wallpaper
- picom - Xorg Compositor https://wiki.archlinux.org/index.php/Picom
- bat - better cat
- htop - better top
- unzip
- gnupg - GNU programs: gpg, gpg-agent, etc
- tree
- fzf - Fuzzy Search
- jq - manipulate JSON
- binutils
- file
- exa - better ls
- fd - better find
- ripgrep # better grep (rp)
- pax-utils - Static analysis of files: dumpelf, lddtree, etc.
- xorg.xev - keyboard codes
- xclip
- clipmenu
- translate-shell - Translate from terminal (trans -s es -t en   word | multiple words | "this is a sentence.")
- curl
- wget
- openvpn
- direnv
-
- libreoffice
- dropbox
- enpass
- lesspass-cli
- thunderbird
- obs-studio

- konsole   - mediocre terminal
- alacritty - GPU-accelerated

- wine - execute windows binaries

- gimp
- scrot  - Screenshots
- nomacs - jpg,png viewer
- gv     - postscript/ghostscript viewer
- vlc

- cplex

- zathura - EPUB, PDF and XPS
- typora - Markdown

- udisks
- parted
- ncdu    - Disk space usage analyzer
-
- zeal - docs for java, c++, rust
-
- slack
- zoom-us
- skypeforlinux
- hexchat
- rtv - Reddit terminal viewer
- discord

- postgresql - (psql included)
- pgcli

- awscli
-
- bind - $ dig www.example.com +nostats +nocomments +nocmd

- jekyll
- bundler

- lingeling - Fast SAT solver
- z3        - Fast SMT solver

- docker-compose
- lazydocker

- texlive.combined.scheme-full - contains every TeX Live package.
- pythonPackages.pygments - required by package minted (code highlight)

- R
- RStudio

- [ ggplot2 dplyr xts aplpack readxl openxlsx
-   prob Rcmdr RcmdrPlugin_IPSUR rmarkdown tinytex
-   rprojroot RcmdrMisc lmtest FactoMineR car
-   psych sem rgl multcomp HSAUR
- ];

- nodejs
- yarn

- Agda
- AgdaStdlib

- # C & C++
- gnumake
- gcc
- gecode - c++ library for constraint satisfiability problems.

- rustc
- cargo
- rls - lsp
- rustfmt
- evcxr - repl
-
- ghc
- cabal-install
- stack     - Note: non-haskell dependencies at .stack/config.yaml
- llvm_6    - Haskell backend
-
- # Haskell runtime dependencies
- gsl
-
- # Profiling in haskell
- (haskell.lib.doJailbreak haskellPackages.threadscope)
- #(haskell.lib.doJailbreak haskellPackages.eventlog2html)
- haskellPackages.profiteur
- haskellPackages.prof-flamegraph flameGraph
-
- # Haskell bin
- haskellPackages.fast-tags
- haskellPackages.ghcid
- haskellPackages.xmobar
- haskellPackages.hoogle
- haskellPackages.pandoc
- haskellPackages.hlint
- haskellPackages.hindent
- haskellPackages.brittany
- haskellPackages.ormolu
- haskellPackages.stylish-haskell

- haskellPackages.BNFC   # bnfc -m Calc.cf
- haskellPackages.alex   # BNFC dependency
- haskellPackages.happy  # BNFC dependency

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

TODO: update instructions for

These are the instructions for Ubuntu:

```bash
apt install zsh # Install zsh
chsh -s $(which zsh) # change user shell
echo $SHELL # check shell is zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # Install oh-my-zsh
# Install a powerline font: https://github.com/powerline/fonts
ln -s ~/dotfiles/.zshrc ~/.zshrc # link
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
# Oppen the shell and follow the powerlevel10k wizard
```

### GPG

```bash
# Install
sudo pacman -Syy gnupg

# Encrypt
gpg -c filename  # Insert your password in the prompt

# Decrypt
gpg filename.gpg  # Insert your password in the prompt
```

