# This is the proper way to override haskellPackages but
# I do not want them to conflict with the current installed ones.
#
# When you have the time, remove the old ones and use this method.
{
  allowBroken = true;

  # $ nix-env -iA cachix -f https://cachix.org/api/v1/install
  # $ cachix use ghc-nix, ghcide-nix, all-hies, iohk

  # To install this: $ nix-build '<nixpkgs>' -A myHaskellEnv

  # TODO
  # - On ghc901 ghc compiles fine but hls doesn't
  # - Install everything together..
  packageOverrides = pkgs:
    let
      compilerVersion = "ghc884"; # "ghc901";

      githubTarball = owner: repo: rev:
        builtins.fetchTarball {
          url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
        };

      #oldPkgs = import (githubTarball "NixOS" "nixpkgs" "nixos-19.03") {};

      # TODO
      # iowa-stdlib = pkgs.callPackage ./iowa-stdlib { inherit (pkgs.stdenv) mkDerivation; inherit (pkgs.fetchFromGitHub); };

    in {
      haskellPackages = pkgs.haskellPackages.override {
        overrides = self: super: { # super ~ non-overriden
          myHaskellEnv = (pkgs.haskell.packages.${compilerVersion}.ghcWithHoogle
            (p:
              with p; [
                # Libs
                xmonad-extras
                xmonad-contrib
                dbus # Required to compile xmonad (pacman:xmonad install it's own ghc version...)

                # Tools
                cabal-install
                stack
                # Placing ghcid/ghcide here doesn't work :(
              ]));

          # TODO
          #.overrideAttrs (oldAttrs: rec {
          #  buildInputs = [ self.haskellPackages.ghcid ];
          #});

          myGhcid = pkgs.haskell.packages.${compilerVersion}.ghcid;

          myHLS = pkgs.haskell-language-server.override { supportedGhcVersions = [ "884" "901" ]; };

          myAgda = pkgs.agda.withPackages (p: [ p.standard-library
                                                #iowa-stdlib # TODO
                                              ]);

          # BROKEN (r is installed via pacman)
          #myR = oldPkgs.rstudioWrapper.override { packages = with oldPkgs.rPackages; [ aplpack ]; };
      };
    };
  };
}
