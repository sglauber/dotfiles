{pkgs, ...}: {
  imports = [
    ./mpv.nix
    ./rnnoise.nix
    ./spicetify.nix
  ];

  home.packages = with pkgs; [
    # audio control
    pavucontrol
    pulsemixer
  ];
}
