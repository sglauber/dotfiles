{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  wallpaper = builtins.fetchurl {
    url = "https://i.imgur.com/z5gvgwP.jpeg";
    sha256 = "sha256-cQScI9mm4b9lyPX59jbqawqKXrHyAXIVrRWRk3f0LXQ=";
  };
in {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${wallpaper}
    wallpaper = , ${wallpaper}
  '';

  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Hyprland wallpaper daemon";
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${lib.getExe inputs.hyprpaper.packages.${pkgs.system}.default}";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
