self: super:

let
  codeExtensions = (with super.vscode-extensions; [
    ms-python.python
    ms-vscode-remote.remote-ssh
    ms-vsliveshare.vsliveshare
  ]) ++ super.vscode-utils.extensionsFromVscodeMarketplace [
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
    }
  ];
in {

  vscode-with-extensions = super.vscode-with-extensions.override {
    vscodeExtensions = codeExtensions;
  };
}
