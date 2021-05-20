/* Build and activate:
     $ home-manager switch

   Rollback:
     $ home-manager generations
     /nix/store/dfg5bj0c1slq78vybdnmll0iz9ddld6l-home-manager-generation
     ...
     $ /nix/store/dfg5bj0c1slq78vybdnmll0iz9ddld6l-home-manager-generation/activate
*/
{ config, pkgs, ... }:

let
  bootstrap = pkgs;

  nixpkgsSource = builtins.fromJSON (builtins.readFile ./nixpkgs.json);

  # Update using `$ update.sh` - Get commit from https://status.nixos.org
  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    inherit (nixpkgsSource) rev sha256;
  };

  rust-overlay = import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz");

  other-overlays = map (fileName: import (./overlays + "/${fileName}"))
    (builtins.attrNames (builtins.readDir ./overlays));

  overlays = [rust-overlay] ++ other-overlays;

  nixpkgs = import src { inherit overlays; };

in {

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "arnau";
  home.homeDirectory = "/home/arnau";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  nixpkgs.config = import ./nixpkgs-config.nix;
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  # dotfiles
  home.file = {
    # FIXME
    ".bloop/_bloop".source = ./bloop-zsh-completions;

    ".agda" = {
      source = ../.agda;
      recursive = true;
    };
  };

  # Check dependencies not installed by nix with `$ nix-env --query`
  home.packages = [
    # Nix
    nixpkgs.cachix # https://docs.cachix.org/
    nixpkgs.niv # https://github.com/nmattia/niv
    nixpkgs.nixfmt
    nixpkgs.nix-diff # https://github.com/Gabriel439/nix-diff
    nixpkgs.nix-prefetch-git
    nixpkgs.nix-serve # https://github.com/edolstra/nix-serve
    # nixpkgs.rnix-lsp TODO

    # TODO
    # https://github.com/nix-community/nix-direnv

    # Agda
    nixpkgs.agda

    # Haskell
    nixpkgs.cabal2nix
    nixpkgs.haskPkgs.hlint
    # nixpkgs.haskPkgs.alex
    # nixpkgs.haskPkgs.happy
    # nixpkgs.haskPkgs.BNFC
    nixpkgs.ghc # custom ghc
    nixpkgs.haskPkgs.stack
    nixpkgs.haskPkgs.haskell-language-server
    nixpkgs.haskPkgs.ghcid
    nixpkgs.haskPkgs.ormolu

    # Rust
    # https://github.com/oxalica/rust-overlay
    (nixpkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
      extensions = [ "rust-src" "rust-analyzer-preview" ];
    }))

    # Java
    nixpkgs.jdk11_headless
    nixpkgs.jasmin
    nixpkgs.maven

    # Scala
    nixpkgs.sbt-with-scala-native
    nixpkgs.coursier
    nixpkgs.bloop
    nixpkgs.metals
    nixpkgs.ammonite
    nixpkgs.scalafmt
  ];
}
