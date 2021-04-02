# Neovim

## Keybindings

See [keybindings](./keybindings.md)

## Installation

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

## Coc (LSP)

The following steps are optional and only needed for specific languages.

### Rust

``` bash
# Execute inside neovim
:CocInstall coc-rust-analyzer
```

### Python

`coc-jedi` is automatically installed through vim-plug (no need to run anything like in rust). 
Same for `syntastic`.

### Haskell

Automatically installed.

### c/c++

Automatically installed.

## Troubleshooting

__Duplicates entries on `coc`__

Try `:CocList services` and see if only one service is running. In my case, multiple servers where running. I fixed it by removing `python` from `coc-settings.json` since `coc-jedi` was somehow registered (coc-rust-analyzer does the same)

__pipenv + ultisnippets__

Ultisnippets uses python3 which is not found in the correct folder inside the pipenv shell.

Solution: `pipenv install pynvim`
