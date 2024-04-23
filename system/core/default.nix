{lib, ...}:
# default configuration shared by all hosts
{
  imports = [
    ./boot.nix
    ./locale.nix
    ./security.nix
    ./users.nix
  ];

  # don't touch this
  system.stateVersion = lib.mkDefault "23.11";

  # compresses half the ram for use as swap
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}
