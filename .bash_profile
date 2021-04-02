#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -e /home/arnau/.nix-profile/etc/profile.d/nix.sh ]; then . /home/arnau/.nix-profile/etc/profile.d/nix.sh; fi

if [ -d "$HOME/.bin" ] ; then PATH="$HOME/.bin:$PATH"; fi

if [ -d "$HOME/.local/bin" ] ; then PATH="$HOME/.local/bin:$PATH"; fi

if [ -d "$HOME/.emacs.d/bin" ] ; then PATH="$HOME/.emacs.d/bin:$PATH"; fi

if [ -d "$HOME/.cabal/bin" ] ; then PATH="$HOME/.cabal/bin:$PATH"; fi

if [ -d $(npm bin) ] ; then PATH=$(npm bin):$PATH; fi

source "$HOME/.cargo/env"
