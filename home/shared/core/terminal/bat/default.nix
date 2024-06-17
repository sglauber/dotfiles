{
  config,
  pkgs,
  ...
}: {
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batwatch
      prettybat
    ];
    config = {
      style = "plain";
      pager = "less -FR";
      theme = "ansi";
    };
  };

  home = {
    sessionVariables = {
      PAGER = "bat";
      MANPAGER = "sh -c 'col --no-backspaces --spaces | bat --language man'";
      MANROFFOPT = "-c";
    };
  };
}
