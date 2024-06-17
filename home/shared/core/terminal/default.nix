{pkgs, ...}: {
  imports = [
    # import folders first

    ./alacritty
    ./bat
    ./bottom
    ./eza
    ./foot
    ./git
    # ./gpg
    ./neovim
    ./nix
    ./ripgrep
    ./skim
    ./ssh
    ./yazi
    ./yt-dlp
    ./zsh
    ./zoxide
  ];

  # home.packages = with pkgs; [
  #   # archives
  #   zip
  #   unzip
  #   unrar

  #   # media
  #   amberol
  #   viewnior
  #   yt-dlp

  #   # misc
  #   libnotify
  #   fontconfig

  #   # utils
  #   du-dust
  #   duf
  #   fd
  #   file
  #   jaq
  #   killall
  #   ripgrep
  # sd

  #   onefetch
  # ];
}
