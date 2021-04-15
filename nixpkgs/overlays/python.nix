# More on https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.section.md
self: super: {
  python = self.python38.withPackages (ps:
    with ps; [
      scipy
      numpy
      pandas
      scikitlearn
      matplotlib
      python-language-server
      pylint
    ]);
}
