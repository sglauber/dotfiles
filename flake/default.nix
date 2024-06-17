_: {
  imports = [
    ./nixos.nix
    ./home-manager.nix
  ];

  perSystem = {pkgs, ...}: {
    formatter = pkgs.alejandra;
  };
}
