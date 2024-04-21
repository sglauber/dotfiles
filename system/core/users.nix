{pkgs, ...}: {
  users.users.lonen = {
    isNormalUser = true;
    description = "Glauber Santana";
    shell = pkgs.zsh;
    initialPassword = "notasecret";
    extraGroups = [
      "audio"
      "networkmanager"
      "video"
      "wheel"
    ];
    packages = with pkgs; [neovim];
  };
}
