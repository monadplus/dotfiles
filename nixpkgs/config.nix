{
  allowBroken = true;

  # $ nix-env -iA cachix -f https://cachix.org/api/v1/install
  # $ cachix use ghc-nix, ghcide-nix, all-hies, iohk

  # Cached HIE: https://github.com/Infinisil/all-hies/
  # Cached ghcide: https://github.com/cachix/ghcide-nix

  # To install this: $ nix-env -f '<nixpkgs>' -iA myHaskellEnv

  packageOverrides = super:
    let
      self = super.pkgs;

      # TODO Upgrade when cached
      compilerVersion = "ghc884"; # "ghc8102";

      githubTarball = owner: repo: rev:
        builtins.fetchTarball {
          url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
        };

      # This ghcide version takes advantage of cachix.
      ghcide-nix = (import (githubTarball "cachix" "ghcide-nix" "master")
        { })."ghcide-${compilerVersion}";
      # nb. The new ghc version may not be supported. Check the repo (link on top)
    in {
      myHaskellEnv = (self.haskell.packages.${compilerVersion}.ghcWithHoogle
        (haskellPackages:
          with haskellPackages; [
            # Libs
            xmonad-extras
            xmonad-contrib
            dbus # Required to compile xmonad (pacman:xmonad install it's own ghc version...)

            # Tools
            cabal-install
            stack # Placing ghcid/ghcide here doesn't work :(
            # stack is not present because it is not currently cached
            QuickCheck
            safe-money
            singletons # 2.6
          ]));

      # Doesn't work
      #.overrideAttrs (oldAttrs: rec {
      #buildInputs = [ self.haskellPackages.ghcid ];
      #});

      ghcid = self.haskell.packages.${compilerVersion}.ghcid;

      haskell-language-server =
        self.haskell.packages.${compilerVersion}.haskell-language-server;

      ghcide = ghcide-nix;
    };
}
