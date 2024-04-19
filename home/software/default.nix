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
    jq
    cliphist
    vesktop
    inputs.matugen.packages.${pkgs.system}.default
  ];
}
