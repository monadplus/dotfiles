# self = final derivation;
# super = previous overlay;
self: super:

let
  overrideHask = ghc: hpkgs:
    hpkgs.override {
      overrides = haskellSelf: haskellSuper:
        {
          # This makes Agda's compilation faster but it makes **you** compile it which is a A LOT of compilation.
          #   meanwhile, let's take advantage of nixos server cache.
          #
          # Agda = super.haskell.lib.dontHaddock haskellSuper.Agda;
        };
    };
in {
  /*
  I can install ghc901 alone but it fails with any dependency.

  Setup: Encountered missing or private dependencies:
  base >=4.5 && <4.15

  builder for '/nix/store/qhdp4fhkfm88dma5zrfnsj76wlc73hd0-cryptohash-md5-0.11.100.1.drv' failed with exit code 1
  building '/nix/store/3xhsa8g5yczmvgbv4f67hp3skd3kbss5-cryptohash-sha1-0.11.100.1.drv'...
  cannot build derivation '/nix/store/npsn83a8p63y2n97g8pkfvgpk6sd9qz1-uuid-1.3.14.drv': 1 dependencies couldn't be built
  cannot build derivation '/nix/store/wncq6lkrgjh9ksfv8141fmmignp6shwg-lsp-1.1.1.0.drv': 1 dependencies couldn't be built
  cannot build derivation '/nix/store/n0k056z85i1n0x7laky8hajc49vknrwi-rebase-1.6.1.drv': 1 dependencies couldn't be built
  building '/nix/store/ljpiyzlzd61010pk5hxcsydm3496dk8v-cryptohash-sha256-0.11.102.0.drv'...
  cannot build derivation '/nix/store/ycib239ln17783wkvjw1hyvklvkmrwkz-haskell-language-server-1.0.0.0.drv': 1 dependencies couldn't be built
  */
  ghcDefaultVersion = "ghc8104";
  haskellPackages = overrideHask self.ghcDefaultVersion
    self.haskell.packages.${self.ghcDefaultVersion};
  haskPkgs = self.haskellPackages;

  haskellPackages_8_8 = self.haskell.packages.ghc884;
  haskellPackages_8_10 = self.haskell.packages.ghc8104;
  haskellPackages_9_0 = self.haskell.packages.ghc901;

  ghc = self.haskellPackages.ghcWithHoogle (p:
    with p; [
      cabal-install

      # xmonad requirements
      xmonad-extras
      xmonad-contrib
      dbus
    ]);

  haskell-language-server = super.haskell-language-server.override {
    supportedGhcVersions = [ (builtins.substring 3 10 self.ghcDefaultVersion) ];
  };
}
