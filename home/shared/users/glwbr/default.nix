{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../core

    # Browsers
    ../../optional/browsers/chrome
    ../../optional/browsers/qutebrowser

    # Media
    ../../optional/media/mpv
    # ../../optional/media/spotify

    # Window Managers
    ../../optional/wm/wayland/hyprland
    ../../optional/wm/wayland/sway

    # Misc
    ../../optional/cli/pfetch
    ../../optional/cli/foot
  ];

  home = {
    username = "glwbr";
    homeDirectory = "/home/glwbr";
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  programs = {
    home-manager.enable = true;
  };
}
