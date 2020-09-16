# Neovim

### Keybindings

See [keybindings](./keybindings.md)

### Installation

Execute the following commands:

```bash
# Some utilities that we will need
sudo apt install git curl -y

# Clone this repo
git clone git@github.com:monadplus/dotfiles.git ~/dotfiles
cd dotfiles

# Link this directory to neovim's init.vim directory
mkdir ~/.config
ln -s ~/dotfiles/nvim ~/.config/nvim/

# According to the official documentation https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu
#
# First we install neovim python dependencies
sudo apt-get install python3 python3-dev python3-pip python3-neovim -y
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
# Check :python3 import sys; print(sys.version)
# Otherwise something went wrong

# Some plugins require node, yarn and python installed in the system.
# `pynvim` is also required for some python plugins
# Not sure if this is required anymore
pip3 install pynvim
sudo apt install nodejs yarn -y

# Install Nix
sudo curl -L https://nixos.org/nix/install | sh

# Install fast-tags (for ctags in neovim)
# fast-tags are used to generate ctags from Haskell sources
# In the configuration, every save on a haskell project, runs fast-tags to create the ctags or update them.
nix-env -iA nixpkgs.haskellPackages.fast-tags

# (Optional) Install ghc, cabal and stack
nix-env -iA nixpkgs.haskell.compiler.ghcXXX
nix-env -iA nixpkgs.haskellPackages.cabal-install
nix-env -iA nixpkgs.haskellPackages.stack

# Install vim-plug plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# (Optional but recommended) Install a nerd font for icons and a beautiful airline bar (https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts) (I'll be using Iosevka for Powerline)
curl -fLo ~/.fonts/Iosevka\ Term\ Nerd\ Font\ Complete.ttf --create-dirs https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Term%20Nerd%20Font%20Complete.ttf
# font-manager works well
# apt install font-manager

# (Optional) Alias vim -> nvim
# echo "alias vim='nvim'" >> ~/.bashrc

# Enter Neovim and install plugins
nvim -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall' # will take some minutes

# Some plugins require additional configuration

# YouCompleteMe
cd ~/.local/share/nvim/plugged/YouCompleteMe
sudo apt install cmake -y
./install.py --rust-completer # This only enables support for rust (and python by default)

# direnv
sudo apt install direnv -y

# hoogle
nix-env -iA nixpkgs.haskellPackages.hoogle
hoogle generate # this takes some minutes

# ghcid
nix-env -iA nixpkgs.haskellPackages.ghcid

#
```
