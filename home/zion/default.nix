{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # inputs.nix-colors.homeManagerModules.default
    # outputs.homeManagerModules.example
    ../shared/users/glwbr
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  home.packages = with pkgs; [
    comma # Install and run programs by sticking a , before them
    bc # Calculator
    # ncdu # TUI disk usage
    ripgrep
    fd # Better find
    # httpie # Better curl
    # diffsitter # Better diff
    jq # JSON pretty printer and manipulator
    # timer # To help with my ADHD paralysis
    nixd # Nix LSP
    alejandra # Nix formatter
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
