{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.gh];

  # enable scrolling in git diff
  # home.sessionVariables.DELTA_PAGER = "less -R";

  programs.git = {
    enable = true;
    userName = "Glauber Santana";
    userEmail = "glauber.silva14@gmail.com";
  };
}
