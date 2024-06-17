_: {
  imports = [
    ./boot
    ./fonts
    ./git
    ./locale
    ./security
    ./sops
    ./ssh
    ./xdg
    ./zsh
  ];

  programs = {
    light.enable = true;
  };
}
