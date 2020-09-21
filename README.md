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
- exa             # better ls
- fd              # better find
- pax-utils       # Static analysis of files: dumpelf, lddtree, etc.
- xorg.xev        # keyboard codes
- xclip
- clipmenu
- translate-shell # trans -s es -t en   word | multiple words | "this is a sentence."
- curl
- wget
- openvpn
- direnv
-
- # Apps
- libreoffice
- dropbox
- #pkgs.unstable.enpass
- lesspass-cli
- thunderbird
- obs-studio
-
- # BitTorrent
- transgui
-
- # Printers
- system-config-printer # GUI
-
- # Browsers
- # chromium
- # firefox is installed below with custom extensions.
-
- # Terminals
- konsole   # default
- alacritty # GPU-based
-
- # Wine: https://www.winehq.org/
- wine # execute windows binaries
-
- # Image Processing
- gimp
- scrot  # Screenshots
- nomacs # jpg,png viewer
- gv     # postscript/ghostscript viewer
-
- # Video Player
- vlc
-
- # Linear Programming
- (cplex.override { releasePath = /home/arnau/cplex; })
-
- # Readers
- zathura # EPUB, PDF and XPS
- typora  # Markdown
-
- # Disk utility
- udisks
- parted
- ncdu    # Disk space usage analyzer
-
- # Docs
- zeal # note: works offline
-
- # Chats
- slack
- zoom-us
- skypeforlinux
- hexchat
- rtv # Reddit terminal viewer: https://github.com/michael-lazar/rtv
- (discord # .override { nss = pkgs.nss_3_52;}
-       .overrideAttrs (oldAttrs: { src = builtins.fetchTarball https://discord.com/api/download?platform=linux&format=tar.gz;})
- ) # Fix to open links on browser.
-
- # Databases
- postgresql # psql included
- pgcli
-
- # AWS
- awscli
-
- # DNS
- bind # $ dig www.example.com +nostats +nocomments +nocmd
-
- # Jekyll
- jekyll
- bundler
-
- lingeling # Fast SAT solver
- z3        # Fast SMT solver
- (haskell.lib.dontCheck haskellPackages.mios) # Haskell SAT solver
-
- # Docker
- docker-compose lazydocker
-
- # LaTeX
- texlive.combined.scheme-full # contains every TeX Live package.
- pythonPackages.pygments # required by package minted (code highlight)
-
- # Nix related
- nix-prefetch-git
- cachix
- nixops
- nix-index # nix-index, nix-locate
- nix-deploy # Lightweight nixOps, better nix-copy-closure.
- # It takes a lot of type to build after a channel update
- steam-run  # Run executable without a nix-derivation.
- patchelf   # $ patchelf --print-needed binary_name # Prints required libraries for the dynamic binary.
-            # Alternative: ldd, lddtree
- haskellPackages.niv             # https://github.com/nmattia/niv#getting-started
- haskellPackages.nix-derivation # pretty-derivation < /nix/store/00ls0qi49qkqpqblmvz5s1ajl3gc63lr-hello-2.10.drv
- # TODO hocker does not even compile
- # (haskell.lib.doJailbreak haskellPackages.hocker) # https://github.com/awakesecurity/hocker
-
- # Python
- python2nix # python -mpython2nix pandas
-
- # RStudio
- # On the shell: nix-shell --packages 'rWrapper.override{ packages = with rPackages; [ ggplot2 ]; }'
- # ( rstudioWrapper.override {
- #   packages = with rPackages;
- #     [ ggplot2 dplyr xts aplpack readxl openxlsx
- #       prob Rcmdr RcmdrPlugin_IPSUR rmarkdown tinytex
- #       rprojroot RcmdrMisc lmtest FactoMineR car
- #       psych sem rgl multcomp HSAUR
- #     ];
- #   }
- # )
-
- # Node.js
- nodejs yarn
- nodePackages.node2nix # https://github.com/svanderburg/node2nix#installation
-
- # Agda
- haskellPackages.Agda AgdaStdlib
-
- # C & C++
- gnumake gcc
- gecode # c++ library for constraint satisfiability problems.
-
- # Rust
- rustc
- cargo
- rls # language server
- rustfmt
- evcxr # repl
-
- # Haskell
- ghc
- cabal-install
- stack     # Note: non-haskell dependencies at .stack/config.yaml
- cabal2nix
- llvm_6    # Haskell backend
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
-
- # TODO Needs configuration and has very little features so far.
- #unstable.haskellPackages.haskell-language-server
-
- # Broken: fixed here but still not in nixos-20.03 https://github.com/NixOS/nixpkgs/pull/85656
- (haskellPackages.stylish-haskell.override {
-   HsYAML = haskellPackages.HsYAML_0_2_1_0;
-   HsYAML-aeson = haskellPackages.HsYAML-aeson.override {
-     HsYAML = haskellPackages.HsYAML_0_2_1_0;
-   };
- })
-
- # Parsing tools
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

