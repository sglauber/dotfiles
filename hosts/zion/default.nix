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

    ../shared/core
    ../shared/users/glwbr

    ../shared/optional/bluetooth.nix
    ../shared/optional/hyprland.nix

    ../shared/optional/nvidia.nix
    ../shared/optional/pipewire.nix
    ../shared/optional/power.nix
    ../shared/optional/wireless.nix
    #../shared/optional/rnnoise.nix

    # Host specific options
    ./disko.nix
  ];

  networking.hostName = "zion";

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    channel.enable = false;
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config.allowUnfree = true;
  };

  # powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    adb.enable = true;
    kdeconnect.enable = true;
  };

  system.stateVersion = "24.05";
}
