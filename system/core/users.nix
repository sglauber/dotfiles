{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  sops.secrets.glwbr-password = {
    sopsFile = ../../hosts/shared/secrets.yaml;
    neededForUsers = true;
  };

  users.mutableUsers = false;
  users.users.glwbr = {
    description = "Glauber Santana";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "adbusers"
        "network"
        "networkmanager"
        "wireshark"
        "docker"
        "podman"
        "git"
        "libvirtd"
      ];

    hashedPasswordFile = config.sops.secrets.glwbr-password.path;
    # openssh.authorizedKeys.keys = [];
    packages = [pkgs.home-manager];
  };
}
