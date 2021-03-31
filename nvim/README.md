# Neovim

### Keybindings

See [keybindings](./keybindings.md)

### Installation

After this steps everything should work out of the box except some languages that require external tooling.

```bash
# Install neovim and its dependencies
sudo pacman -Syu neovim python-pynvim nodejs yarn python

# Check python support (python is not supported)
:python3 import sys; print(sys.version) # Should print python version

# Link this directory to neovim's init.vim directory
ln -s ~/dotfiles/nvim ~/.config

# Install vim-plug plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Enter Neovim and install plugins
nvim -c ':PlugInstall' -c ':UpdateRemotePlugins' -c ':qall' # Go for a coffee or tea..

# (Recommended) Alias vim -> nvim
echo "alias vim='nvim'" >> ~/.bashrc
```

The following steps are optional and only needed for specific languages.

#### direnv

```bash
# direnv
paru direnv
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc # echo 'eval "$(direnv hook zsh)"' >> ~/.bashrc
```

#### python

- LSP: [coc-jedi](https://github.com/pappasam/coc-jedi) (can also lint with an extra tool).
- Linter: [syntastic](https://github.com/vim-syntastic/syntastic) + `pylint`.

`coc-jedi` is automatically installed through vim-plug (no need to run anything like in rust). Same for `syntastic`.

#### rust

```bash
# Install rustup toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# rustup +nightly component add rust-analyzer-preview
# Since the only option is from nightly, I just do not install it
# and let coc install it by itself.

# Alternative you could install it via pacman
sudo pacman -Syu rust rust-analyzer

# Execute inside neovim
:CocInstall coc-rust-analyzer
```

#### haskell

There are several alternatives to install `ghc`/`cabal`/`stack`. The recommended one is [ghcup](https://www.haskell.org/ghcup/).
I use [nix](https://nixos.org/) because it is not haskell's specific.

#### c/c++

Requires installing [ccls](https://github.com/MaskRay/ccls/wiki).

Arch linux includes a pacman package `sudo pacman -Syu ccls`.

#### Troubleshooting

__Duplicates entries on `coc`__

Try `:CocList services` and see if only one service is running. In my case, multiple servers where running. I fixed it by removing `python` from `coc-settings.json` since `coc-jedi` was somehow registered (coc-rust-analyzer does the same)

__pipenv + ultisnippets__

Ultisnippets uses python3 which is not found in the correct folder inside the pipenv shell.

Solution: `pipenv install pynvim`
