{pkgs, ...}: {
  users.users.glwbr = {
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
