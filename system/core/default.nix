{lib, ...}: {
  imports = [
    ./boot.nix
    ./locale.nix
    ./security.nix
    ./users.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = lib.mkDefault "24.05";
}
