{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkIf;
  packageNames = map (p: p.pname or p.name or null) config.home.packages;
  hasPackage = name: lib.any (x: x == name) packageNames;

  hasEza = hasPackage "eza";
  hasRipgrep = hasPackage "ripgrep";

  hasBat = config.programs.bat.enable;
  hasKitty = config.programs.kitty.enable;
  hasNeovim = config.programs.neovim.enable;
in {
  programs.zsh = {
    shellAliases = {
      q = "exit";
      trimall = "sudo fstrim -va";
      temp = "cd /tmp/";

      # home manager
      hm = "home-manager --flake .";
      hms = "home-manager --flake . switch";

      # nix
      n = "nix";
      nb = "nix build";
      nd = "nix develop -c $SHELL";
      nf = "nix flake";
      ns = "nix shell";
      nsn = "nix shell nixpkgs#";

      nr = "nixos-rebuild --flake .";
      nrs = "nixos-rebuild --flake . switch";
      snr = "sudo nixos-rebuild --flake .";
      snrs = "sudo nixos-rebuild --flake . switch";

      cleanup = "sudo nix-collect-garbage --delete-older-than 1d";
      listgen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      remove = "nix-store --gc";

      # nix packages
      installed = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq | sk";
      installedall = "nix-store --query --requisites /run/current-system | sk";

      # git
      g = "git";
      commit = "git add . && git commit -m";
      push = "git push";
      pull = "git pull";
      gcld = "git clone --depth";
      gco = "git checkout";
      gitgrep = "git ls-files | rg";
      gitrm = "git ls-files --deleted -z | xargs -0 git rm";

      ip = "ip --color";

      # cp mv rm mkdir
      cp = "cp -vr";
      md = "mkdir -p";
      mv = "mv -v";
      rm = "rm -rv";

      # cat grep
      cat = mkIf hasBat "bat";
      grep = mkIf hasRipgrep "rg";

      # misc
      df = "df -h";
      du = "du-dust";
      fm = "yazi";
      jctl = "journalctl -p 3 -xb";

      # youtube-dl
      ytmp3 = "yt-dlp --ignore-errors -x --audio-format mp3 -f bestaudio --audio-quality 0 --embed-metadata --embed-thumbnail --output '%(title)s.%(ext)s'";

      # systemctl
      us = "systemctl --user";
      rs = "sudo systemctl";
    };
  };
}
