# Neovim

### Keybindings

See [keybindings](./keybindings.md)

### Installation

Execute the following commands:

```bash
# Install neovim and its dependencies
sudo pacman -Syy neovim python-pynvim

# Check python support (python is not supported)
:python3 import sys; print(sys.version) # Should print python version

# Link this directory to neovim's init.vim directory
ln -s ~/dotfiles/nvim ~/.config/nvim/

# Install vim-plug plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Some plugins require node, yarn and python installed in the system.
sudo apt install nodejs yarn python -y

# Install Nix
sudo curl -L https://nixos.org/nix/install | sh

# Install fast-tags (for ctags in neovim)
nix-env -iA nixpkgs.haskellPackages.fast-tags

# Enter Neovim and install plugins
nvim -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall' # will take some minutes

# Some plugins require additional configuration

# YouCompleteMe
cd ~/.local/share/nvim/plugged/YouCompleteMe
sudo pacman -Syy cmake
# Installing autocomplete for rust:
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh # Install Rustup
./install.py --rust-completer # This only enables support for rust (and python by default)

# direnv
sudo yay -Syy direnv
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc # echo 'eval "$(direnv hook zsh)"' >> ~/.bashrc

# hoogle
nix-env -iA nixpkgs.haskellPackages.hoogle
hoogle generate # this takes some minutes

# ghcid
nix-env -iA nixpkgs.haskellPackages.ghcid

# (Optional) Alias vim -> nvim
echo "alias vim='nvim'" >> ~/.bashrc

# (Optional) Install ghc, cabal and stack
nix-env -iA nixpkgs.haskell.compiler.ghcXXX
nix-env -iA nixpkgs.haskellPackages.cabal-install
nix-env -iA nixpkgs.haskellPackages.stack
```
