{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lonen";
  home.homeDirectory = "/home/lonen";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    google-chrome
    pulsemixer
    tmux
    spotify
    obs-studio
    pavucontrol
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # "nvim".source = /home/lonen/.config/neovim;
    "nvim".source = ../../modules/home-manager/nvim;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  home.sessionVariables = {
    EDITOR = "neovim";
    VISUAL = "neovim";
    NODE_REPL_HISTORY = "~/.local/share/node_repl_history";
    GOPATH = "~/.local/share/go";
    CARGO_HOME = "~/.local/share/cargo";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.bash.enable = false;
  programs.neovim = {
    enable = true;
    viAlias = true;
  };
  programs.git = {
    userEmail = "glauber.silva14@gmail.com";
    userName = "Glauber S";
  };
}
