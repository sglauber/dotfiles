{
  lib,
  pkgs,
  config,
  inputs,
  hostname,
  username,
  stateVersion,
  ...
}: {
  imports =
    [
      inputs.sops-nix.homeManagerModules.sops
      inputs.nix-index-db.hmModules.nix-index

      ./shared/core
      ./shared/optional/browsers/chrome
      ./shared/optional/wm/wayland/sway
      ./shared/optional/wm/wayland/hyprland
      ./shared/optional/wm/gtk.nix
      ./shared/optional/terminal/pfetch
      ./shared/optional/transient-services
      ./shared/optional/wm/wayland/services

      ./shared/optional/obsidian
      ./shared/optional/media/default.nix
      ./shared/optional/media/mpv.nix
      ./shared/optional/wm/wayland/hyprlock.nix
    ]
    ++ lib.optional (builtins.pathExists (./. + "/users/${username}")) ./users/${username}
    ++ lib.optional (builtins.pathExists (./. + "/hosts/${hostname}")) ./hosts/${hostname};

  home = {
    inherit stateVersion;
    inherit username;
    homeDirectory = "/home/${username}";
    sessionVariables = {
      LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
      LESSKEY = "${config.xdg.cacheHome}/less/lesskey";
      DIRENV_LOG_FORMAT = "";
      NIX_AUTO_RUN = "1";
    };
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
