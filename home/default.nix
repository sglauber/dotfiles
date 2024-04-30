{
  self,
  inputs,
  ...
}: let
  # get these into the module system
  extraSpecialArgs = {inherit inputs self;};

  homeImports = {"glwbr@zion" = [./home.nix];};
  inherit (inputs.hm.lib) homeManagerConfiguration;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  _module.args = {inherit homeImports;};

  flake = {
    homeConfiguration = {
      "glwbr_zion" = homeManagerConfiguration {
        modules = homeImports."glwbr@zion";
        inherit pkgs extraSpecialArgs;
      };
    };
  };
}
