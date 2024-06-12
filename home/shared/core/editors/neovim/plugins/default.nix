_: {
  imports = [
    ./completion.nix
  ];

  programs.nixvim = {
    colorschemes.rose-pine.enable = true;
  };
}
