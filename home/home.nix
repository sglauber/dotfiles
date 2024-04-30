{
  lib,
  self,
  inputs,
  ...
}: {
  imports = [
    # import folders first
    ./editors
    ./software
    ./services

    ./specialisations.nix
    inputs.matugen.nixosModules.default
    inputs.nix-index-db.hmModules.nix-index
    inputs.hyprlock.homeManagerModules.default
    inputs.hypridle.homeManagerModules.default
    self.nixosModules.theme
  ];

  home = {
    username = "glwbr";
    homeDirectory = "/home/glwbr";
    stateVersion = "23.11";
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      lib = prev.lib // {colors = import "${self}/lib/colors" lib;};
    })
  ];
}
