# The first argument (self) corresponds to the final package set.
# You should use this set for the dependencies of all packages specified in your overlay.
# For example, all the dependencies of rr in the example above come from self,
# as well as the overridden dependencies used in the boost override.

# The second argument (super) corresponds to the result of the evaluation of
# the previous stages of Nixpkgs. It does not contain any of the packages added
# by the current overlay, nor any of the following overlays. This set should be
# used either to refer to packages you wish to override, or to access functions
# defined in Nixpkgs. For example, the original recipe of boost in the above example,
# comes from super, as well as the callPackage function.
self: super:

let
  overrideHask = ghc: hpkgs:
    hpkgs.override {
      overrides = haskellSelf: haskellSuper: {
        # This affects package agda.
        Agda = super.haskell.lib.dontHaddock haskellSuper.Agda;
      };
    };
in {
  # I can install ghc901 alone but it fails with any dependency.
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
      # For my arch xmonad
      xmonad-extras
      xmonad-contrib
      dbus
    ]);

  haskell-language-server =
    super.haskell-language-server.override { supportedGhcVersions = [ (builtins.substring 3 10 self.ghcDefaultVersion) ]; };
}
