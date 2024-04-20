{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # import folders first
    ./anyrun
    ./media
    ./terminal
    ./utilities
    ./wayland

    ./gtk.nix
  ];

  home.packages = with pkgs; [
    # social
    vesktop
    tdesktop

    # personalizations
    nixos-icons
    inputs.matugen.packages.${pkgs.system}.default

    # misc
    overskride
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
