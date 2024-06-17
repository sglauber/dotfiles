{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # Hardware specific configurations
    ./hardware.nix

    # Disk partitions
    ./disko.nix

    ../shared/core
    ../shared/users/glwbr
    ../shared/users/anacl

    # save power on laptops
    ../shared/optional/tlp

    ../shared/optional/quietboot
    ../shared/optional/adb
    ../shared/optional/bluetooth
    ../shared/optional/docker
    ../shared/optional/jmtpfs
    ../shared/optional/hyprland
    ../shared/optional/nvidia
    ../shared/optional/power
    ../shared/optional/sound
    ../shared/optional/sway
    ../shared/optional/wireless
  ];

  networking.hostName = "zion";

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
      warn-dirty = false;
    };

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    channel.enable = false;
  };

  nixpkgs = {
    # overlays = [
    #   outputs.overlays.additions
    #   outputs.overlays.modifications
    #   outputs.overlays.unstable-packages
    # ];

    config.allowUnfree = true;
  };

  services.fstrim.enable = true;

  system.stateVersion = "24.05";
}
