{inputs, ...}: {
  # nh default flake
  environment.variables.FLAKE = "/home/lonen/workspace/dotfiles";

  programs.nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
  };
}
