# Neovim

### Keybindings

See [keybindings](./keybindings.md)

### Installation

After this steps everything should work out of the box except some languages that require external tooling.

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

# Enter Neovim and install plugins
nvim -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall' # Go for a coffee or tea..

# (Recommended) Alias vim -> nvim
echo "alias vim='nvim'" >> ~/.bashrc
```

The following steps are optional and only needed for specific languages.

#### direnv

```bash
# direnv
sudo yay -Syy direnv
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc # echo 'eval "$(direnv hook zsh)"' >> ~/.bashrc
```

#### rust

```bash
# Install rustup toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-analyzer

# Execute inside neovim
:CocInstall coc-rust-analyzer
:CocInstall coc-pyright
```

#### haskell

There are several alternatives to install `ghc`/`cabal`/`stack`. The recommended one is [ghcup](https://www.haskell.org/ghcup/).
I use [nix](https://nixos.org/) because it is not haskell's specific.

```bash
# Install nix for some dependency management
sudo curl -L https://nixos.org/nix/install | sh

# Install ghc, cabal and stack
nix-env -iA nixpkgs.haskell.compiler.ghcXXX
nix-env -iA nixpkgs.haskellPackages.cabal-install
nix-env -iA nixpkgs.haskellPackages.stack

# hoogle
nix-env -iA nixpkgs.haskellPackages.hoogle
hoogle generate # this takes some minutes

# ghcid
nix-env -iA nixpkgs.haskellPackages.ghcid
```

#### c/c++

Requires installing [ccls](https://github.com/MaskRay/ccls/wiki).

Arch linux includes a pacman package `sudo pacman -Syy ccls`.
