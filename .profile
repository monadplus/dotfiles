if [ -d "$HOME/.cabal/bin" ] ; then PATH="$HOME/.cabal/bin:$PATH"; fi
if [ -d "$HOME/.local/bin" ] ; then PATH="$HOME/.local/bin:$PATH"; fi
if [ -d "$HOME/.cargo/env" ] ; then source "$HOME/.cargo/env"; fi
if [ -e /home/arnau/.nix-profile/etc/profile.d/nix.sh ]; then . /home/arnau/.nix-profile/etc/profile.d/nix.sh; fi
