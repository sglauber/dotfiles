{config, ...}: let
  data = config.xdg.dataHome;
  conf = config.xdg.configHome;
  cache = config.xdg.cacheHome;
in {
  imports = [
    ./bat.nix
    ./bottom.nix
    ./cli.nix
    ./foot.nix
    ./git.nix
    ./inlyne.nix
    ./neofetch.nix
    ./nix.nix
    ./screenshot-area.nix
    ./screenshot-full.nix
    ./skim.nix
    ./transient-services.nix
    ./yazi
    ./xdg.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  home.sessionVariables = {
    # clean up ~
    LESSHISTFILE = "${cache}/less/history";
    LESSKEY = "${conf}/less/lesskey";

    WINEPREFIX = "${data}/wine";
    XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";

    EDITOR = "nvim";
    DIRENV_LOG_FORMAT = "";

    # auto-run programs using nix-index-database
    NIX_AUTO_RUN = "1";
  };
}
