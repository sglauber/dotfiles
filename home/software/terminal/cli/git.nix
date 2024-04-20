{
  pkgs,
  config,
  ...
}: let
  cfg = config.programs.git;
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIo9GDELaZbOouKRTTRYurcL9XF3JflFI/+h3FBKgASL glauber.silva14@gmail.com";
in {
  home.packages = [pkgs.gh];

  # enable scrolling in git diff
  home.sessionVariables.DELTA_PAGER = "less -R";

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Glauber Santana";
    userEmail = "glauber.silva14@gmail.com";

    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519";
      signByDefault = false;
    };

    delta = {
      enable = true;
      options.${config.theme.name} = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";
      core.editor = "nvim";
      push.default = "current";
      repack.usedeltabaseoffset = "true";
      pull.ff = "only";
      pull.rebase = true;

      # https://git-scm.com/book/en/v2/Git-Tools-Rerere
      rerere = {
        enabled = true;
        autoupdate = true;
      };

      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = config.home.homeDirectory + "/" + config.xdg.configFile."git/allowed_signers".target;
      };
    };

    aliases = {
      a = "add";
      b = "branch";
      c = "commit";
      ca = "commit --amend";
      cm = "commit -m";
      co = "checkout";
      d = "diff";
      ds = "diff --staged";
      p = "push";
      pf = "push --force-with-lease";
      pl = "pull";
      l = "log";
      r = "rebase";
      s = "status";
      forgor = "commit --amend --no-edit";
      graph = "log --all --decorate --graph --oneline";
      oops = "checkout --";
    };

    ignores = ["*~" "*result*" ".direnv" "node_modules"];
  };

  xdg.configFile."git/allowed_signers".text = ''
    ${cfg.userEmail} namespaces="git" ${key}
  '';
}
