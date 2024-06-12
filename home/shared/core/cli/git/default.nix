{
  pkgs,
  config,
  ...
}: let
  cfg = config.programs.git;
in {
  home.sessionVariables.DELTA_PAGER = "less -R";

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Glauber Santana";
    userEmail = "glauber.silva14@gmail.com";

    signing = {
      # generate my own
      key = "000000000000000000000000";
      signByDefault = false;
    };

    delta = {
      enable = true;
      # options.${config.theme.name} = true;
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

      # # https://git-scm.com/book/en/v2/Git-Tools-Rerere
      # rerere = {
      #   enabled = true;
      #   autoupdate = true;
      # };
    };

    aliases = {
      a = "add";
      b = "branch";
      c = "checkout";
      ca = "commit --amend";
      cm = "commit -m";
      co = "commit";
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

  # xdg.configFile."git/allowed_signers".text = ''
  #   ${cfg.userEmail} namespaces="git" ${cfg.signing.key}
  # '';
}
