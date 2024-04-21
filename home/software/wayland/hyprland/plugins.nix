{
  inputs,
  pkgs,
  ...
}: let
  hyprfocus = inputs.hyprfocus.packages.${pkgs.system}.default;
in {
  wayland.windowManager.hyprland.settings = {
    plugins = [hyprfocus];

    plugin.hyprfocus = {
      enabled = true;

      animate_floating = true;
      focus_animation = "shrink";
      keyboard_focus_animation = "shrink";
      mouse_focus_animation = "shrink";

      bezier = [
        "bezIn, 0.05,0.9,0.1,1.05"
        "bezOut, 0.05,0.9,0.1,1.05"
        "overshot, 0.05, 0.9, 0.1, 1.05"
        "smoothOut, 0.36, 0, 0.66, -0.56"
        "smoothIn, 0.25, 1, 0.5, 1"
        "realsmooth, 0.28,0.9,0.1,1.05"
      ];

      flash = {
        flash_opacity = 0.9;
        in_bezier = "realsmooth";
        in_speed = 0.5;

        out_bezier = "realsmooth";
        out_speed = 3;
      };

      shrink = {
        shrink_percentage = 0.8;

        in_bezier = "bezIn";
        in_speed = 0.5;

        out_bezier = "bezOut";
        out_speed = 3;
      };
    };
  };
}
