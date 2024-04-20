{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./nixpkgs.nix
    ./nh.nix
    ./substituters.nix
  ];

  # install git system wide
  environment.systemPackages = [pkgs.git];

  nix = {
    # pin the registry to avoid re-downloading a nixpkgs version
    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

    # set the path for channels compat
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "/etc/nix/registry.json";

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      trusted-users = ["root" "@wheel"];
    };

    distributedBuilds = true;
  };
}
