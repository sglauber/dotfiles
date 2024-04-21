{
  inputs,
  pkgs,
  ...
}: let
  hyprfocus = inputs.hyprfocus.packages.${pkgs.system}.default;
in {
  wayland.windowManager.hyprland = {
    plugins = [hyprfocus];
    settings = {
      plugin.hyprfocus = {
        enabled = true;

        animate_floating = true;
        focus_animation = "flash";

        bezier = [
          "realsmooth, 0.28,0.9,0.1,1.05"
        ];

        flash = {
          flash_opacity = 0.9;
          in_bezier = "realsmooth";
          in_speed = 0.5;

          out_bezier = "realsmooth";
          out_speed = 3;
        };
      };
    };
  };
}
