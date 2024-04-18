{
  self,
  inputs,
  ...
}: let
  # get these into the module system
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {"lonen@anchor" = [./home.nix];};
  inherit (inputs.hm.lib) homeManagerConfiguration;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfiguration = {
      "lonen_anchor" = homeManagerConfiguration {
        modules = homeImports."lonen@anchor";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
