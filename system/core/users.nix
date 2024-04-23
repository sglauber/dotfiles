{pkgs, ...}: {
  users.users.lonen = {
    isNormalUser = true;
    description = "Glauber Santana";
    shell = pkgs.zsh;
    initialPassword = "notasecret";
    extraGroups = [
      "audio"
      "docker"
      "networkmanager"
      "video"
      "wheel"
    ];
    packages = with pkgs; [neovim];
  };
}
