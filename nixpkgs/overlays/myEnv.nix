# ~/.config/nixpkgs/overlays/myEnv.nix

# $ nix-env -iA myEnv
self: super: {
  myEnv = super.buildEnv {
    name = "myEnv";
    paths = [

      # Python
      (self.python38.withPackages (
        ps: with ps; [
          scipy
          numpy
          scikit-learn
          matplotlib
          python-language-server
          pylint
          jedi
        ]
      ))

    ];
  };
}
