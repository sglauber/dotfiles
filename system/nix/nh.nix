{inputs, ...}: {
  # nh default flake
  environment.variables.FLAKE = "/home/glwbr/workspace/dotfiles";

  programs.nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
  };
}
