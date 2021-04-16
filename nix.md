# Nix

## nix-copy-closure

### Copy shell.nix product

The steps are the following:

``` sh
nix-build --no-out-link shell.nix -A inputDerivation
nix-store --query --references \
    /nix/store/rw6i1wk9iv0286xi2b6kpw4ynk4pldyh-example-shell

# Optional
scp shell.nix arnau@ip:~

# See issues below
nix-copy-closure --to arnau@ip \
    /nix/store/rw6i1wk9iv0286xi2b6kpw4ynk4pldyh-example-shell
```

During the `nix-copy-closure` step, we encountered the following errros:

- [zsh:1: command not found: nix-store](https://superuser.com/questions/1321059/nix-copy-closure-command-not-found-error/1321594).
- [error: serialised integer 7161674624452356180 is too large for type 'j'](https://github.com/NixOS/nixpkgs/issues/37287)

To solve this you need to add the following text before your "ssh-rsa ..." in `~/.ssh/authorized_keys` in the host.

``` sh
# Make sure .profile exist and references the .profile from ~/dotfiles
command=". ~/.profile; if [ -n \"$SSH_ORIGINAL_COMMAND\" ]; then eval \"$SSH_ORIGINAL_COMMAND\"; else exec \"$SHELL\"; fi"
```
