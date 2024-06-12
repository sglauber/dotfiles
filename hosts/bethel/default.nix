_: {
  imports = [
    # Import shared options
    # Get folders first
    ../shared/core
    ../shared/users/glwbr

    ../shared/optional/bluetooth.nix
    ../shared/optional/nvidia.nix
    ../shared/optional/pipewire.nix
    # ../shared/optional/power.nix
    ../shared/optional/wireless.nix

    # Host specific options
    ./disko.nix
    ./hardware.nix
  ];

  networking.hostName = "bethel";
  system.stateVersion = "24.05";
}
