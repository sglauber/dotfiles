_: {
  imports = [
    # Host specific options
    ./disko.nix
    ./hardware.nix

    # Import shared options
    ../shared/core
    ../shared/users/glwbr

    ../shared/optional/bluetooth.nix
    ../shared/optional/wireless.nix
  ];

  networking.hostName = "bethel";
  system.stateVersion = "24.05";
}
