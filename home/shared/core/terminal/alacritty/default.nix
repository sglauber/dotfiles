{pkgs, ...}: {
  programs.alacritty = {
    enable = true;

    settings = {
      colors.draw_bold_text_with_bright_colors = true;

      cursor = {
        vi_mode_style = {
          shape = "Beam";
          blinking = "Always";
        };
      };

      env = {
        TERM = "xterm-256color";
      };

      font = {
        normal.family = "DejaVu Sans Mono";
        size = 18;
      };

      keyboard.bindings = [
        {
          key = "Escape";
          mods = "Alt";
          action = "ToggleViMode";
        }
      ];

      mouse = {
        hide_when_typing = true;
      };

      scrolling.history = 10000;

      window = {
        decorations = "none";
        dynamic_padding = true;
        opacity = 0.95;
        padding.x = 2;
        padding.y = 2;
        startup_mode = "Maximized";
      };

      import = with pkgs; [
        (fetchurl {
          url = "https://raw.githubusercontent.com/rose-pine/alacritty/dfdb46476dc963d4e8784e4f32766ba603550bc6/dist/rose-pine.toml";
          hash = "sha256-MheSmzz02ZLAOS2uaclyazu6E//eikcdFydFfkio0/U=";
        })
      ];
    };
  };
}
