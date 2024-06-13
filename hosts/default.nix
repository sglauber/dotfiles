{
  self,
  inputs,
  homeImports,
  ...
}: {
  flake = {
    nixosConfigurations = let
      # shorten paths
      inherit (inputs.nixpkgs.lib) nixosSystem;
      mod = "${self}/system";

      # get the basic config to build on top of
      inherit (import "${self}/system") desktop laptop;

      # get these into the module system
      specialArgs = {inherit inputs self;};
    in {
      zion = nixosSystem {
        inherit specialArgs;
        modules =
          desktop
          ++ laptop
          ++ [
            ./zion
            {
              home-manager = {
                users.glwbr.imports = homeImports."glwbr@zion";
                extraSpecialArgs = specialArgs;
              };
            }
            # inputs.sops-nix.nixosModules.sops
          ];
      };
    };
  };
}
