#!/usr/bin/env sh

function show_usage() {
    printf "Usage: $0 commit-id\n"
    return 0
}

if [ ! -z "$1" ]; then # $# -eq 1
    nix-prefetch-git https://github.com/NixOS/nixpkgs.git $1 > nixpkgs.json
else
    show_usage
fi
