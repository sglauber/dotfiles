{pkgs, ...}: {
  imports = [
    # import folders first
    ./yazi

    ./bat.nix
    ./bottom.nix
    ./git.nix
    ./gpg.nix
    ./inlyne.nix
    ./nix.nix
    ./skim.nix
    ./screenshot-area.nix
    ./screenshot-full.nix
    ./transient-services.nix
    ./xdg.nix
  ];

  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar

    # media
    amberol
    viewnior
    yt-dlp

    # misc
    libnotify
    fontconfig

    # utils
    bottom
    du-dust
    duf
    fd
    file
    jaq
    killall
    ripgrep

    onefetch
  ];

  programs = {
    eza.enable = true;
    ssh.enable = true;
  };
}
