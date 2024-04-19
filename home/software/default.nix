{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./terminal
    ./gtk.nix
  ];

  home.packages = with pkgs; [
    cliphist
    vesktop
    inputs.matugen.packages.${pkgs.system}.default
  ];
}
