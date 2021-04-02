{
  allowBroken = true;
  allowUnfree = true;

  # To install this: $ nix-env -f '<nixpkgs>' -iA myHaskellEnv

  packageOverrides = super:
    let
      self = super.pkgs;

      # TODO ghc901 fails..
      compilerVersion = "ghc884";

      # TODO not pinned
      githubTarball = owner: repo: rev:
        builtins.fetchTarball {
          url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
        };

      vsExtensions = (with super.pkgs.vscode-extensions; [
          ms-python.python
          ms-vscode-remote.remote-ssh
          ms-vsliveshare.vsliveshare
        ]) ++ super.pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "remote-ssh-edit";
            publisher = "ms-vscode-remote";
            version = "0.65.1";
            sha256 = "0ajbn3iyhxajj7v6j5sh74j9bm6qh2sx0964vlillbiwr5i845f0";
          }
          {
            name = "nix-env-selector";
            publisher = "arrterian";
            version = "1.0.4";
            sha256 = "0dm0pmzc5kbkw4kgmpyla8w78wn3cngd5g16d94c1svc7wdgrk5a";
         }];

    in {
      myHaskellEnv = (self.haskell.packages.${compilerVersion}.ghcWithHoogle
        (haskellPackages:
          with haskellPackages; [
            # Libs
            xmonad-extras
            xmonad-contrib
            xmonad-utils
            dbus

            # Tools
            cabal-install
            stack
            # Placing ghcid/ghcide here doesn't work :(
          ]));

      myGhcid = self.haskell.packages.${compilerVersion}.ghcid;

      myHLS = self.haskell-language-server.override { supportedGhcVersions = [ "884" ]; };

      myAgda = self.agda.withPackages (p: [ p.standard-library
                                            # TODO still broken on 31/03/2021
                                            #p.iowa-stdlib
                                          ]);

      # Using the one from pacman
      #myVscode = self.vscode-with-extensions.override {
                    #vscodeExtensions = vsExtensions;
                 #};
    };
}
