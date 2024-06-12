{pkgs, ...}: {
  imports = [];
  wayland.windowManager.sway = {
    enable = true;
    extraOptions = ["--unsupported-gpu"];
  };
}
