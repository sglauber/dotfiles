{
  pkgs,
  config,
  ...
}: let
  cursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 28;
  };
in {
  home.pointerCursor =
    cursor
    // {
      x11.enable = true;
      gtk.enable = true;
    };

  gtk = {
    enable = true;

    font = {
      name = "DejaVu Sans";
      size = 14;
    };

    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };

    cursorTheme = cursor;

    theme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme.override {
        tweaks = ["rimless" "black" "float"];
      };
    };

    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintslight"
        gtk-xft-rgba="rgb"
      '';
    };

    gtk3 = {
      extraConfig = {
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
        gtk-xft-rgba = "rgb";
        gtk-application-prefer-dark-theme = 1;
      };
    };

    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
}
