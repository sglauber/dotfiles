{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  packageNames = map (p: p.pname or p.name or null) config.home.packages;
  hasPackage = name: lib.any (x: x == name) packageNames;
  hasEza = hasPackage "eza";
in {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    autocd = true;

    dotDir = ".config/zsh";
    enableCompletion = true;
    dirHashes = {
      dl = "${config.home.homeDirectory}/Downloads";
      dev = "${config.home.homeDirectory}/workspace";
      dots = "${config.home.homeDirectory}/workspace/nix-config";
    };

    syntaxHighlighting = {
      enable = true;
      # highlighters = ["main" "brackets" "pattern" "cursor" "regexp" "root" "line"];
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
      size = 10000;
      path = "${config.xdg.dataHome}/zsh_history";
    };

    plugins = [];

    shellAliases = {
      cat = "bat";
      bethel = "ssh -l glwbr ";

      nr = "nixos-rebuild --flake .";
      nrs = "nixos-rebuild --flake . switch";
      hm = "home-manager --flake .";
      hms = "home-manager --flake .#zion switch";

      ls = mkIf hasEza "eza --icons";
    };
  };
}
