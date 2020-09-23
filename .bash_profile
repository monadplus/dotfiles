#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Nix
if [ -e /home/arnau/.nix-profile/etc/profile.d/nix.sh ]; then . /home/arnau/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Rust
export PATH="$HOME/.cargo/bin:$PATH"
