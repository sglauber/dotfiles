{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./settings.nix
    ./keybinds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
