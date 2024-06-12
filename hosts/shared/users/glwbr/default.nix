{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  sops.secrets.glwbr-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  users.mutableUsers = false;
  users.users.glwbr = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups =
      [
        "wheel"
        "video"
        "audio"
      ]
      ++ ifTheyExist [
        "network"
        "networkmanager"
        "wireshark"
        "docker"
        "podman"
        "git"
        "libvirtd"
      ];

    hashedPasswordFile = config.sops.secrets.glwbr-password.path;
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./keys/id_demo.pub)
    ];
    packages = [pkgs.home-manager];
  };
}
