{config, ...}: let
  colors = {
    rose = {
      background = "191724";
      foreground = "e0def4";
      regular0 = "26233a"; # black (Overlay)
      regular1 = "eb6f92"; # red (Love)
      regular2 = "31748f"; # green (Pine)
      regular3 = "f6c177"; # yellow (Gold)
      regular4 = "9ccfd8"; # blue (Foam)
      regular5 = "c4a7e7"; # magenta (Iris)
      regular6 = "ebbcba"; # cyan (Rose)
      regular7 = "e0def4"; # white (Text)
      bright0 = "6e6a86"; # bright black (Overlay)
      bright1 = "eb6f92"; # bright red (Love)
      bright2 = "31748f"; # bright green (Pine)
      bright3 = "f6c177"; # bright yellow (Gold)
      bright4 = "9ccfd8"; # bright blue (Foam)
      bright5 = "c4a7e7"; # bright magenta (Iris)
      bright6 = "ebbcba"; # bright cyan (Rose)
      bright7 = "e0def4"; # bright white (Text)
    };

    moon = {
      background = "232136";
      foreground = "e0def4";
      regular0 = "393552"; # black (Overlay)
      regular1 = "eb6f92"; # red (Love)
      regular2 = "3e8fb0"; # green (Pine)
      regular3 = "f6c177"; # yellow (Gold)
      regular4 = "9ccfd8"; # blue (Foam)
      regular5 = "c4a7e7"; # magenta (Iris)
      regular6 = "ea9a97"; # cyan (Rose)
      regular7 = "e0def4"; # white (Text)
      bright0 = "393552"; # bright black (Overlay)
      bright1 = "eb6f92"; # bright red (Love)
      bright2 = "3e8fb0"; # bright green (Pine)
      bright3 = "f6c177"; # bright yellow (Gold)
      bright4 = "9ccfd8"; # bright blue (Foam)
      bright5 = "c4a7e7"; # bright magenta (Iris)
      bright6 = "ea9a97"; # bright cyan (Rose)
      bright7 = "e0def4"; # bright white (Text)
    };
  };
in {
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "DejaVu Sans Mono:size=16";
        font-size-adjustment = 1;
        dpi-aware = "no";
        # pad = "5x5center";
        notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
      };

      mouse.hide-when-typing = "yes";

      scrollback = {
        lines = 10000;
        multiplier = 5;
        indicator-position = "none";
      };

      url = {
        launch = "xdg-open \${url}";
        label-letters = "sadfjklewcmpgh";
        osc8-underline = "url-mode";
        protocols = "http, https, ftp, ftps, file";
        uri-characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+=\"'()[]";
      };

      cursor = {
        color = "191724 e0def4";
        style = "beam";
        beam-thickness = 1;
      };

      colors = {alpha = 0.9;} // colors.rose;
    };
  };
}
