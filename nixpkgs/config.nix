{
  # To install this:
  #   $ nix-env -iA nixpkgs.myGHC
  #   $ nix-env -f '<nixpkgs-stable>' -iA myGHC
  #
  # To uninstall: $ nix-env -e '<name of the derivation>'
  #               $ nix-env -e '.*haskell.*'                                                                                                                                                  ✔  11:27:17
  #
  # githubTarball = owner: repo: rev:
  #   builtins.fetchTarball {
  #     url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
  #   };
  #
  # oldPkgs = import (githubTarball "NixOS" "nixpkgs" "nixos-19.03") {};

  allowBroken = true;
  allowUnfree = true;
}
