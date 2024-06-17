{
  pkgs,
  lib,
  config,
  ...
}: {
  # imports = [./packages.nix];

  sops.secrets.anacl-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  users.mutableUsers = false;
  users.users.anacl = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ];
    hashedPasswordFile = config.sops.secrets.anacl-password.path;
  };
}
