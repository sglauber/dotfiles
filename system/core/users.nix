{pkgs, ...}: {
  users.users.glwbr = {
    isNormalUser = true;
    shell = pkgs.zsh;
    initialPassword = "notasecret";
    # !TODO: move this from here to home manager apply 'ifTheyExist' to group
    extraGroups = [
      "audio"
      "docker"
      "networkmanager"
      "video"
      "wheel"
    ];
  };
}
