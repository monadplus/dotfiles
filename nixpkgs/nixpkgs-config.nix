{
    allowBroken = true;
    allowUnfree = true;

    # If set to true (the default), any non-content-addressed path added or copied to the Nix store
    # (e.g. when substituting from a binary cache) must have a valid signature, that is, be signed
    # using one of the keys listed in trusted-public-keys or secret-key-files. Set to false to disable signature checking.
    require-sigs = false;
}
