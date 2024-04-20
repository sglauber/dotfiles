{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  c = config.programs.matugen.theme.colors.colors.${config.theme.name};
  pointer = config.home.pointerCursor;
  homeDir = config.home.homeDirectory;

  hyprfocus = inputs.hyprfocus.packages.${pkgs.system}.default;
in {
  wayland.windowManager.hyprland = {
    plugins = [hyprfocus];

    settings = {
      "$MOD" = "SUPER";

      env = ["QT_WAYLAND_DISABLE_WINDOWDECORATION,1"];

      exec-once = [
        "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
        "systemctl --user start clight"
        "hyprlock"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "echo us > /tmp/kb_layout"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1"
        "hyprctl dispatcher focusmonitor 1"
      ];

      xwayland.force_zero_scaling = true;

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";

        follow_mouse = false;
        repeat_delay = 140;
        repeat_rate = 30;

        sensitivity = 0;
        force_no_accel = true;
        accel_profile = "flat";

        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
        };
      };

      misc = {
        disable_autoreload = true;
        animate_mouse_windowdragging = false;
        no_direct_scanout = false;

        vrr = true;
        vfr = true;

        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        force_default_wallpaper = false;
      };

      general = {
        monitor = [
          "HDMI-A-1, 2560x1440@60, 1920x0, 1"
          "eDP-1, 1920x1080@60, 0x0, 1"
        ];
        gaps_in = 4;
        gaps_out = 8;
        border_size = 1;
        layout = "dwindle";
        no_cursor_warps = true;

        "col.inactive_border" = "0xff908caa"; #"rgb(${c.primary});";
        "col.active_border" = "0xffebbcba 0xffeb6f92 0xffc4a7e7 45deg";
        "no_border_on_floating" = false;
      };

      decoration = {
        rounding = 1;

        blur = {
          enabled = true;
          size = 8; # 8
          passes = 1; # 1
          new_optimizations = true;
          ignore_opacity = true;
          noise = "0.0117"; # 0.1
          contrast = "1.5"; # 1.1
          brightness = "1"; # 1
          xray = true;
        };

        fullscreen_opacity = 1;
        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_offset = "0 8";
        shadow_range = 50;
        shadow_render_power = 3;
        "col.shadow" = "rgba(00000055)";
        blurls = ["lockscreen" "waybar" "popups"];
      };

      animations = {
        enabled = true;
        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "easeinoutsine, 0.37, 0, 0.63, 1"
        ];

        animation = [
          "windowsIn, 1, 1.7, easeOutCubic, slide"
          "windowsOut, 1, 1.7, easeOutCubic, slide"
          "windowsMove, 1, 2.5, easeinoutsine, slide"

          # fading
          "fadeIn, 1, 3, easeOutCubic"
          "fadeOut, 1, 3, easeOutCubic"
          "fadeSwitch, 1, 5, easeOutCirc"
          "fadeShadow, 1, 5, easeOutCirc"
          "fadeDim, 1, 6, fluent_decel"
          "border, 1, 2.7, easeOutCirc"
          "workspaces, 1, 2, fluent_decel, slide"
          "specialWorkspace, 1, 3, fluent_decel, slidevert"
        ];
      };

      dwindle = {
        no_gaps_when_only = false;
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_is_master = true;
      };

      "$VIDEODIR" = "$HOME/Videos";
      "$NOTIFY" = "notify-send -h string:x-canonical-private-synchronouse:hypr-cfg -u low";
      "$COLORPICKER" = "${homeDir}/.config/hypr/scripts/colorpicker";
      "$LAYERS" = "^(eww-.+|bar|system-menu|anyrun|gtk-layer-shell|osd[0-9]|dunst)$";

      bind = [
        "$MOD, Escape, exec, wlogout -p layer-shell"
        ", F9, exec, wl-screenrec -f $VIDEODIR/$(date +%Y-%m-%d_%H-%M-%S).mp4"
        ", F9, exec, $NOTIFY 'Recording started'"
        ", F10, exec, killall -s SIGINT wl-screenrec"
        ", F10, exec, $NOTIFY 'Recording stopped'"

        ", Print, exec, screenshot-full"
        "$MODSHIFT, S, exec, screenshot-area"
        "$MODSHIFT, X, exec, $COLORPICKER"

        "$MOD, D, exec, pkill .anyrun-wrapped || run-as-service anyrun"
        "$MOD, Return, exec, run-as-service foot"
        "CTRL_ALT, L, exec, loginctl lock-session"

        "$MOD, Q, killactive"
        "$MODSHIFT, Q, exit"
        "$MOD, F, fullscreen"
        "$MOD, Space, togglefloating"
        "$MOD, P, pseudo"
        "$MOD, S, togglesplit"
        "$MOD, O, toggleopaque"

        "$MODSHIFT, Space, workspaceopt, allfloat"
        "$MODSHIFT, P, workspaceopt, allpseudotile"

        "$MOD, Tab, cyclenext"
        "$MOD, Tab, bringactivetotop"

        "$MOD, A, togglespecialworkspace"
        "$MODSHIFT, A, movetoworkspace, special"
        "$MOD, C, exec, hyprctl dispatch centerwindow"

        "$MOD, K, movefocus, u"
        "$MOD, J, movefocus, d"
        "$MOD, L, movefocus, r"
        "$MOD, H, movefocus, l"

        "$MODSHIFT, K, movewindow, u"
        "$MODSHIFT, J, movewindow, d"
        "$MODSHIFT, L, movewindow, r"
        "$MODSHIFT, H, movewindow, l"

        "$MODCTRL, K, resizeactive,  0 -20"
        "$MODCTRL, J, resizeactive,  0 20"
        "$MODCTRL, L, resizeactive,  20 0"
        "$MODCTRL, H, resizeactive, -20 0"

        "${builtins.concatStringsSep "\n" (builtins.genList (x: let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in ''
            bind = $MOD, ${ws}, workspace, ${toString (x + 1)}
            bind = $MODSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
            bind = $MOD+CTRL, ${ws}, focusworkspaceoncurrentmonitor, ${toString (x + 1)}
          '')
          10)}"
        "$MOD, mouse_down, workspace, e-1"
        "$MOD, mouse_up, workspace, e+1"
      ];

      bindl = let
        e = "exec, wpctl";
      in [
        ", XF86AudioMute, ${e} set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, ${e} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioStop, exec, playerctl pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      bindle = let
        e = "exec, wpctl";
      in [
        ", XF86AudioRaiseVolume, ${e} set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, ${e} set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%-"
        # backlight
        ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
        ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
      ];

      bindm = ["$MOD, mouse:272, movewindow" "$MOD, mouse:273, resizewindow"];
      windowrulev2 = [
        # "opacity 0.90 0.90,class:^(org.wezfurlong.wezterm)$"
        # "opacity 0.90 0.90,class:^(foot)$"
        # "opacity 0.90 0.90,class:^(Brave-browser)$"
        # "opacity 0.90 0.90,class:^(brave-browser)$"
        # "opacity 0.90 0.90,class:^(firefox)$"
        # "opacity 0.80 0.80,class:^(Steam)$"
        # "opacity 0.80 0.80,class:^(steam)$"
        # "opacity 0.80 0.80,class:^(steamwebhelper)$"
        # "opacity 0.80 0.80,class:^(Spotify)$"
        # "opacity 0.80 0.80,class:^(Code)$"
        # "opacity 0.80 0.80,class:^(thunar)$"
        # "opacity 0.80 0.80,class:^(file-roller)$"
        # "opacity 0.80 0.80,class:^(nwg-look)$"
        # "opacity 0.80 0.80,class:^(qt5ct)$"
        # "opacity 0.80 0.80,class:^(VencordDesktop|Webcord|discord|Discord)"
        # "opacity 0.80 0.70,class:^(pavucontrol)$"
        # "opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$"
        # "opacity 0.80 0.80,class:^(org.telegram.desktop)$"
        # "opacity 0.80 0.80,class:^(code-url-handler)$"
        # "opacity 0.80 0.80,title:^(Spotify( Premium)?)$"
        # "opacity 0.80 0.80,title:^(Spotify( Free)?)$"
        # "opacity 0.90 0.90, class:^(inlyne)$"
        # "opacity 0.90 0.90, class:^(org.qutebrowser.qutebrowser)$"

        "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "float,class:^(pavucontrol)$"
        "float,title:^(Media viewer)$"
        "float,title:^(Volume Control)$"
        "float,class:^(Viewnior)$"
        "float,title:^(DevTools)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
        "float,class:^(com.github.Aylur.ags)$"
        "float,class:^(mpv)$"
        "float,class:^(org.telegram.desktop)"
        "size 380 690,class:^(org.telegram.desktop)"

        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"

        "idleinhibit focus, class:^(mpv|.+exe)$"
        "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
        "idleinhibit fullscreen, class:^(firefox)$"
        "idleinhibit fullscreen, class:^(Brave-browser)$"

        "dimaround, class:^(xdg-desktop-portal-gtk)$"
        "dimaround, class:^(polkit-gnome-authentication-agent-1)$"

        "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"
        "workspace special silent, title:^(Firefox — Sharing Indicator)$"

        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
        "noshadow,class:^(xwaylandvideobridge)$"
      ];

      layerrule = let
        toRegex = list: let
          elements = lib.concatStringsSep "|" list;
        in "^(${elements})$";

        ignorealpha = [
          "calendar"
          "notifications"
          "osd"
          "system-menu"

          "anyrun"
          "popups"
        ];
        layers = ignorealpha ++ ["bar" "gtk-layer-shell"];
      in [
        "blur, ${toRegex layers}"
        "xray 1, ${toRegex ["bar" "gtk-layer-shell"]}"
        "ignorealpha 0.2, ${toRegex ["bar" "gtk-layer-shell"]}"
        "ignorealpha 0.5, ${toRegex (ignorealpha ++ ["music"])}"
      ];

      plugin.hyprfocus = {
        enabled = true;

        animate_floating = true;
        focus_animation = "flash";

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
      };
    };
  };
}
