{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.gh];

  # enable scrolling in git diff
  home.sessionVariables.DELTA_PAGER = "less -R";

  programs.git = {
    enable = true;
    # enable git-lfs
    lfs.enable = true;

    userName = "Glauber Santana";
    userEmail = "glauber.silva14@gmail.com";
    # signing = {
    # key = "";
    # signByDefault = true;
    # };

    delta = {
      enable = true;
      # options.${config.theme.name} = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      diff.colorMoved = "default";
      merge.conflictstyle = "diff3";
      push.autoSetupRemote = true;
      core.editor = "hx";
      push.default = "current";
      merge.stat = "true";
      core.whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
      repack.usedeltabaseoffset = "true";
      pull.ff = "only";
      # rebase = {
      # autoSquash = true;
      # autoStash = true;
      # };

      # https://git-scm.com/book/en/v2/Git-Tools-Rerere
      rerere = {
        enabled = true;
        autoupdate = true;
      };
    };

    aliases = {
      co = "checkout";
      ca = "commit -am";
      d = "diff";
      st = "status";
      br = "branch";
      df = "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
      hist = ''
        log --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)" --graph --date=relative --decorate --all'';
      llog = ''
        log --graph --name-status --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset" --date=relative'';
      edit-unmerged = "!f() { git ls-files --unmerged | cut -f2 | sort -u ; }; hx `f`";
    };

    ignores = ["*~" "*.swp" "*result*" ".direnv" "node_modules"];
  };
}
