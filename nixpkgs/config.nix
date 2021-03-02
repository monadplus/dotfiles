{
  allowBroken = true;

  # To install this: $ nix-env -f '<nixpkgs>' -iA myHaskellEnv

  packageOverrides = super:
    let
      self = super.pkgs;

      # TODO
      compilerVersion = "ghc884"; # "ghc8102";

      githubTarball = owner: repo: rev:
        builtins.fetchTarball {
          url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
        };
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
            stack
            # Placing ghcid/ghcide here doesn't work :(
          ]));

      ghcid = self.haskell.packages.${compilerVersion}.ghcid;

      myHLS = self.haskell-language-server.override { supportedGhcVersions = [ "884" ]; };

      myAgda = self.agda.withPackages (p: [ p.standard-library
                                            # TODO
                                            #iowa-stdlib
                                          ]);
    };
}
