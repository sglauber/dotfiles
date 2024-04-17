{lib, ...}:
# default configuration shared by all hosts
{
  imports = [
    ./users.nix
    ./boot.nix
    ./bluetooth.nix
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  # don't touch this
  system.stateVersion = lib.mkDefault "23.11";

  time.timeZone = lib.mkDefault "America/Bahia";
  time.hardwareClockInLocalTime = lib.mkDefault true;

  # compresses half the ram for use as swap
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
}
