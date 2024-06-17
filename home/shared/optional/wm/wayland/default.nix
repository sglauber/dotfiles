{
  pkgs,
  self,
  ...
}: {
  imports = [
    # Import folders first
    ./dunst
    ./hyprland

    ./hyprlock.nix
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
    # screensharing
    grim
    slurp

    # utils
    # self.packages.${pkgs.system}.wl-ocr
    wl-clipboard
    wl-screenrec
    wlr-randr
    hyprpicker
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
  };
}
