{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./binds.nix
    # ./plugins.nix
    ./rules.nix
    ./settings.nix
  ];

  home = {
    packages = with pkgs; [
      seatd
      jaq
      xorg.xprop
      grimblast
      xwaylandvideobridge
    ];

    file = {
      ".config/hypr/scripts/colorpicker" = {
        source = ./scripts/colorpicker;
        executable = true;
      };
    };
  };

  # Enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
