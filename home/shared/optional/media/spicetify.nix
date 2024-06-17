{
  inputs,
  pkgs,
  config,
  ...
}: {
  # themable spotify
  imports = [
    inputs.spicetify-nix.homeManagerModule
  ];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
    #variant =
    #  if config.theme.name == "light"
    #  then "latte"
    #  else "mocha";
  in {
    enable = true;

    theme = spicePkgs.themes.Catppuccin;

    colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      fullAppDisplay
      fullAlbumDate
      hidePodcasts
      historyShortcut
      playlistIcons
      shuffle
    ];
  };
}
