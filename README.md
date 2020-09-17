Dotfiles
========

### TODO

- aws
- dmenu, htop, psql, trans-shell
- .cabal and .stack
- latex + lualatex(vim render command)
- rust, cargo and friends

- tile manager ?
- Learn tmux
- Emacs

--------------------------------------

These are the steps to follow when starting from a fresh Ubuntu minimal installation (tested with Ubuntu 20.04):

- Install konsole
- Instal Enpass - Requires adding a custom repo to apt
- Install Dropbox - Not distributed through apt. Requires the official .deb
- Open Enpass using dropbox. Add enpass' extensions to firefox.
- Create a new ssh key and add it to github. Run ssh-agent and add the key.
- Follow [nvim instructions](./nvim/README.md)
- stylish-haskell

```bash
ln -s ~/dotfiles/stylish-haskell/.stylish-haskell.yaml ~/.stylish-haskell.yaml
```

- konsole

```bash
ln -s ~/dotfiles/konsole ~/.local/share/konsole
ln -s ~/dotfiles/konsolerc ~/.config/konsolerc
# I couldn't find where the keybindings file is..
# Add them by hand (copy/paste,clear, etc)
```

- Install zsh & oh-my-zsh

```bash
apt install zsh # Install zsh
chsh -s $(which zsh) # change user shell
echo $SHELL # check shell is zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # Install oh-my-zsh
# Install a powerline font: https://github.com/powerline/fonts
ln -s ~/dotfiles/.zshrc ~/.zshrc # link
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k # Install theme and configure using the promp

- (This time I am not installing xmonad. It is a lot of work and I prefer a simpler configuration) Install xmonad & xmobar & stalonetray & dmenu

```bash
# Install
sudo apt install xmonad xmobar stalonetray libghc-xmonad-dev libghc-xmonad-contrib-dev libghc-xmonad-extras-dev libghc-xmonad-wallpaper-dev

# Link the files
sudo mv -n /usr/share/xsessions/xmonad.desktop /usr/share/xsessions/xmonad.desktop.original # mv old
...

TODO

I was following this tutorial repo https://github.com/davidbrewer/xmonad-ubuntu-conf
```

- Install Clipboard Indicator: https://extensions.gnome.org/extension/779/clipboard-indicator/

### Window Manager

Currently using [xmonad](https://xmonad.org/)

My xmonad setup uses:

- xmobar (for displaying additional information on the top bar)
- stalonetray (for the application tray with icons)
- dmenu (for searching/exec applications)

### GPG

```bash
# Encrypt
gpg -c filename  # Insert your password in the prompt

# Decrypt
gpg filename.gpg  # Insert your password in the prompt
```

