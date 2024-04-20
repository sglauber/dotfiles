{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./terminal
    ./gtk.nix
    ./wayland
  ];

  home.packages = with pkgs; [
    # social
    vesktop
    tdesktop

    # personalizations
    nixos-icons
    inputs.matugen.packages.${pkgs.system}.default

    # misc
    catimg
    cliphist
    colord
    ffmpegthumbnailer
    imagemagick
    jq
    pciutils
    xcolor
  ];
}
